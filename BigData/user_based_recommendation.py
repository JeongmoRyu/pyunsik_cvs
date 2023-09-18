from pyspark.ml.recommendation import ALS
from pyspark.sql import SparkSession
from pyspark.sql.functions import when, col, explode  # explode 함수 추가
import redis
import json
import time

# Spark 세션 초기화
spark = SparkSession \
    .builder \
    .appName("ALS") \
    .config("spark.driver.extraClassPath", "/usr/local/spark/myjars/mysql-connector-j-8.1.0.jar") \
    .getOrCreate()

# MySQL 설정
jdbc_url = "jdbc:mysql://j9a505.p.ssafy.io:3308/SparkTest"
properties = {
    "user": "root",
    "password": "gndhqkd123",
    "driver": "com.mysql.cj.jdbc.Driver",
}

# Favorite 테이블과 Product 테이블에서 데이터 읽기
favorite_query = "(SELECT * FROM favorite) as favorite"
favorite_data = spark.read \
    .jdbc(jdbc_url, favorite_query, properties=properties)

product_query = "(SELECT * FROM product2) as product"
product_data = spark.read \
    .jdbc(jdbc_url, product_query, properties=properties)

# 평점 매기기: 좋아요 누른 상품은 5점, 그렇지 않은 상품은 0점
favorite_data = favorite_data.withColumn("rating", when(col("is_deleted") == False, 5).otherwise(0))

favorite_data.show()

# ALS 모델 설정
als = ALS(maxIter=5, regParam=0.01, userCol="user_id", itemCol="product_id", ratingCol="rating")

# 모델 학습
model = als.fit(favorite_data)

# 유저별 상품 추천
user_recs = model.recommendForAllUsers(10)

user_recs.show()

# recommendations 배열을 풀어서 새로운 컬럼에 저장
user_recs = user_recs.withColumn("recommendation", explode("recommendations"))

user_recs.show()

# 새로운 컬럼에서 product_id만 추출
user_recs = user_recs.select("user_id", "recommendation.product_id")

user_recs.show()

# 추천 결과와 Product 테이블 조인
recommendations = user_recs.join(product_data, user_recs.product_id == product_data.id)

product_data.show()

recommendations.show()

# 추천 결과를 JSON 형태로 변환
recommendations_list = []
for row in recommendations.collect():
    recommendations_list.append({
        "userId": row['user_id'],
        "recommandProducts": {
            "productId": row['product_id'],
            "productName": row['product_name'],
            "price": row['price'],
            "badge": row['badge'],
            "filename": row['filename'],
            "isFavorite": row['rating'] == 5
        }
    })

recommendations_json = json.dumps(recommendations_list, ensure_ascii=False)

# recommendations_list 출력
print(recommendations_list)

# Redis 연결 설정
r = redis.Redis(host='j9a505.p.ssafy.io', port=6382, db=0)

# JSON을 Redis에 저장
r.set('recommandProducts', recommendations_json.encode('utf-8'))
