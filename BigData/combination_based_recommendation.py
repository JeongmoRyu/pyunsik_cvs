from pyspark.sql import SparkSession
from pyspark.sql.functions import collect_list, desc
from pyspark.ml.fpm import FPGrowth
import redis
import json
import time

# Spark 세션 초기화
spark = SparkSession \
    .builder \
    .appName("RealTimeCombinationRecommendation") \
    .config("spark.driver.extraClassPath", "/usr/local/spark/myjars/mysql-connector-j-8.1.0.jar") \
    .getOrCreate()

# 시작 시간
start_time = time.time()

# MySQL에서 데이터 읽기
jdbc_url = "jdbc:mysql://j9a505.p.ssafy.io:3308/SparkTest"  # IP와 포트를 자신의 환경에 맞게 수정
properties = {
    "user": "root",  # MySQL 사용자 이름
    "password": "gndhqkd123",  # MySQL 비밀번호
    "driver": "com.mysql.cj.jdbc.Driver",
}

# 조합 데이터 가져오기
query = "(SELECT * FROM combination_item) as combination_item"
df = spark.read \
    .jdbc(jdbc_url, query, properties=properties)

# 조합 생성
combination_list = df.groupBy("combination_id").agg(collect_list("product_id").alias("items"))

combination_list.show()

# FPGrowth 모델 학습
fpGrowth = FPGrowth(itemsCol="items", minSupport=0.001, minConfidence=0.002)
model = fpGrowth.fit(combination_list)

# 연관 규칙 생성
association_rules = model.associationRules

# 연관 규칙을 리스트로 변환
rules_list = [row.asDict() for row in association_rules.collect()]

# 리스트를 JSON 형식으로 변환
rules_json = json.dumps({"rules": rules_list}, ensure_ascii=False)

# Redis 연결 설정
r = redis.Redis(host='j9a505.p.ssafy.io', port=6382, db=0)  # Redis 호스트와 포트를 자신의 환경에 맞게 수정

# JSON을 Redis에 저장 (UTF-8로 인코딩)
r.set('realtime_combination_rules', rules_json.encode('utf-8'))

# 끝난 시간
end_time = time.time()

# 시간 계산
processing_time = end_time - start_time
print(f"Processing time: {processing_time} 초")

# Redis에서 데이터 확인 (테스트용, UTF-8로 디코딩)
print(r.get('realtime_combination_rules').decode('utf-8'))

# Spark 세션 종료
spark.stop()