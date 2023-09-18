from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.window import Window
import redis
import json
import time

# Spark 세션 초기화
spark = SparkSession \
    .builder \
    .appName("ProductRanking") \
    .config("spark.driver.extraClassPath", "/usr/local/spark/myjars/mysql-connector-j-8.1.0.jar") \
    .getOrCreate()

# 시작 시간
start_time = time.time()

# MySQL에서 데이터 읽기
jdbc_url = "jdbc:mysql://j9a505.p.ssafy.io:3308/SparkTest"
properties = {
    "user": "root",
    "password": "gndhqkd123",
    "driver": "com.mysql.cj.jdbc.Driver",
}

query = "(SELECT * FROM product) as product"
df = spark.read \
    .jdbc(jdbc_url, query, properties=properties)

# 카테고리별 favorite_count 랭킹
windowSpec = Window.partitionBy('category').orderBy(desc('favorite_count'))
ranked = df.withColumn("rank", row_number().over(windowSpec))

# 각 카테고리에서 가장 높은 favorite_count를 가진 상품만 선택
top_ranked = ranked.filter(col('rank') <= 10).select('category', 'product_name', 'favorite_count')

# 처리 시간 계산
end_time = time.time()
processing_time = end_time - start_time
print(f"Processing time: {processing_time} 초")

top_ranked.show()

# DataFrame을 리스트로 변환
ranking_list = [{"category": row['category'], "product_name": row['product_name'], "favorite_count": row['favorite_count']} for row in top_ranked.collect()]

# 리스트를 JSON 형식으로 변환
ranking_json = json.dumps({"ranking": ranking_list}, ensure_ascii=False)

# Redis 연결 설정
r = redis.Redis(host='j9a505.p.ssafy.io', port=6382, db=0)

# JSON을 Redis에 저장
r.set('product_ranking', ranking_json.encode('utf-8'))

# Redis에서 데이터 확인 (테스트용)
print(r.get('product_ranking').decode('utf-8'))
