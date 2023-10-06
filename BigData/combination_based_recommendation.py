from pyspark.sql import SparkSession
from pyspark.sql.functions import collect_list, desc
from pyspark.ml.fpm import FPGrowth
import json
import time

# Spark 세션 초기화
spark = SparkSession \
    .builder \
    .appName("CombinationRecommendation") \
    .config("spark.driver.extraClassPath", "/usr/local/spark/myjars/mysql-connector-j-8.1.0.jar") \
    .getOrCreate()

# 시작 시간 기록
start_time = time.time()

# MySQL에서 데이터 읽기
jdbc_url = "jdbc:mysql://j9a505a.p.ssafy.io:3308/business"  # IP와 포트를 자신의 환경에 맞게 수정
properties = {
    "user": "root",  # MySQL 사용자 이름
    "password": "gndhqkd123",  # MySQL 비밀번호
    "driver": "com.mysql.cj.jdbc.Driver",
}

# 조합 데이터 가져오기
query = "(SELECT DISTINCT combination_id, product_id FROM combination_item) as combination_item"  # DISTINCT 추가
df = spark.read \
    .jdbc(jdbc_url, query, properties=properties)

# 조합 생성
combination_list = df.groupBy("combination_id").agg(collect_list("product_id").alias("items"))

# FPGrowth 모델 학습
fpGrowth = FPGrowth(itemsCol="items", minSupport=0.001, minConfidence=0.002)
model = fpGrowth.fit(combination_list)

# 끝난 시간 기록
end_time = time.time()

# 시간 계산
processing_time = end_time - start_time
print(f"데이터를 불러와 모델 훈련까지 걸린 시간: {processing_time} 초")


# 모델 저장
model_path = "/home/ubuntu/models"
model.write().overwrite().save(model_path)

# Spark 세션 종료
spark.stop()
