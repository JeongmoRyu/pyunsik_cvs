from pyspark.sql import SparkSession
from pyspark.sql.functions import *
import redis
import json
import time

# Spark 세션 초기화
spark = SparkSession \
    .builder \
    .appName("RealTimeSearch") \
    .config("spark.driver.extraClassPath", "/usr/local/spark/myjars/mysql-connector-j-8.1.0.jar") \
    .getOrCreate()

#시작시간
start_time = time.time()

# MySQL에서 데이터 읽기
jdbc_url = "jdbc:mysql://j9a505.p.ssafy.io:3308/SparkTest"  # IP와 포트를 자신의 환경에 맞게 수정
properties = {
    "user": "root",  # MySQL 사용자 이름
    "password": "gndhqkd123",  # MySQL 비밀번호
    "driver": "com.mysql.cj.jdbc.Driver",
}

# 오늘 날짜의 검색 로그만 가져오기
#query = "(SELECT * FROM searchlog WHERE DATE(created_at) = CURDATE()) as searchlog"
#df = spark.read \
#    .jdbc(jdbc_url, query, properties=properties)

# 전체 날짜의 검색 로그 가져오기
query = "(SELECT * FROM searchlog WHERE created_at) as searchlog"
df = spark.read \
    .jdbc(jdbc_url, query, properties=properties)

# 실시간 검색어 처리: 단어별로 카운트
search_keywords = df.groupBy("keyword").count().orderBy(desc("count"))

#끝난 시간
end_time = time.time()

#시간 계산
processing_time = end_time - start_time
print(f"Processing time: {processing_time} 초")

search_keywords.show()

# DataFrame을 리스트로 변환
keywords_list = [row['keyword'] for row in search_keywords.collect()]

# 리스트를 JSON 형식으로 변환 (ensure_ascii=False 추가)
search_json = json.dumps({"comments": [{"keyword": k} for k in keywords_list]}, ensure_ascii=False)

# Redis 연결 설정
r = redis.Redis(host='j9a505.p.ssafy.io', port=6382, db=0)  # Redis 호스트와 포트를 자신의 환경에 맞게 수정

# JSON을 Redis에 저장 (UTF-8로 인코딩)
r.set('realtime_search_keywords', search_json.encode('utf-8'))

# Redis에서 데이터 확인 (테스트용, UTF-8로 디코딩)
print(r.get('realtime_search_keywords').decode('utf-8'))
