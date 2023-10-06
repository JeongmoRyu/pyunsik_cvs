## 지금 사용중인 코드

from pyspark.ml.recommendation import ALS
from pyspark.sql import SparkSession
from pyspark.sql.functions import when, col, explode, sum as F_sum
from pyspark.sql.types import LongType
from pyspark.sql.functions import monotonically_increasing_id
import time

# Spark 세션 초기화
spark = SparkSession \
    .builder \
    .appName("ALS") \
    .config("spark.driver.extraClassPath", "/usr/local/spark/myjars/mysql-connector-j-8.1.0.jar") \
    .getOrCreate()

# MySQL 설정
jdbc_url = "jdbc:mysql://j9a505a.p.ssafy.io:3308/business"
properties = {
    "user": "root",
    "password": "gndhqkd123",
    "driver": "com.mysql.cj.jdbc.Driver",
}

start_time = time.time()

# Favorite 테이블에서 데이터 읽기
favorite_query = "(SELECT * FROM favorite) as favorite"
favorite_data = spark.read \
    .jdbc(jdbc_url, favorite_query, properties=properties)
favorite_data = favorite_data.withColumn("rating", when(col("is_deleted") == False, 5).otherwise(0))
favorite_data = favorite_data.select("user_id", "product_id", "rating")

# Log_product 테이블에서 데이터 읽기
log_query = "(SELECT * FROM log_product) as log_product"
log_data = spark.read \
    .jdbc(jdbc_url, log_query, properties=properties)
log_data = log_data.withColumn("rating", when(col("product_id").isNotNull(), 1))
log_data = log_data.select("user_id", "product_id", "rating")



# Log 데이터와 Favorite 데이터 합치기
combined_data = favorite_data.union(log_data)

# 동일한 user_id와 product_id의 경우 평점을 합산
combined_data = combined_data.groupBy("user_id", "product_id").agg(F_sum("rating").alias("rating"))



# ALS 모델 설정 및 훈련
als = ALS(maxIter=5, regParam=0.01, userCol="user_id", itemCol="product_id", ratingCol="rating")
model = als.fit(combined_data)

end_time = time.time()


processing_time = end_time - start_time
print(f"데이터를 불러와 모델 훈련까지 걸린 시간: {processing_time} 초")


# 유저별 상품 추천
user_recs = model.recommendForAllUsers(10)

user_recs.show()

# 유저별 추천 결과를 풀어서 (user_id, product_id, rating) 형태로 만들기
exploded_recs = user_recs.withColumn("recommendations", explode("recommendations"))
refined_recs = exploded_recs.select("user_id", "recommendations.product_id", "recommendations.rating")
refined_recs_with_id = refined_recs.withColumn("id", monotonically_increasing_id())


# MySQL 테이블에 데이터를 저장
refined_recs_with_id.write \
    .jdbc(jdbc_url, "recommended_product", mode="overwrite", properties=properties)



spark.stop()