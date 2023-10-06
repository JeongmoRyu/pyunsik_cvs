from pyspark.sql import SparkSession
from pyspark.sql.functions import col, abs, round, stddev, avg
import time
import random

# Spark 세션 초기화
spark = SparkSession.builder \
    .appName("FoodRecommendation") \
    .config("spark.driver.extraClassPath", "/usr/local/spark/myjars/mysql-connector-j-8.1.0.jar") \
    .getOrCreate()

# 시작 시간
start_time = time.time()

# MySQL에서 데이터 읽기
jdbc_url = "jdbc:mysql://j9a505.p.ssafy.io:3308/SparkTest"
properties = {
    "user": "",
    "password": "",
    "driver": "com.mysql.cj.jdbc.Driver",
}

query = "(SELECT category, product_name, kcal, carb, protein, fat, sodium FROM FinalData) as FinalData"
df = spark.read.jdbc(jdbc_url, query, properties=properties)

# DB에서 랜덤한 음식 하나를 선택
random_food = df.rdd.takeSample(False, 1)[0]
selected_food = {
    "category": random_food.category,
    "product_name": random_food.product_name,
    "kcal": random_food.kcal,
    "carb": random_food.carb,
    "protein": random_food.protein,
    "fat": random_food.fat,
    "sodium": random_food.sodium
}

print(f"선택한 음식: {selected_food['product_name']}")

# 현재 선택한 카테고리를 제외하고 데이터 필터링
filtered_df = df.filter(df.category != selected_food["category"])

# 각 항목별 100%에 가까운 정도를 계산
def calc_percentage(column_name, recommended_value):
    return round(((col(column_name) + selected_food[column_name]) / recommended_value) * 100, 2)

# 각 항목의 퍼센티지 계산
recommendation_df = filtered_df.withColumn("kcal_percentage", calc_percentage("kcal", 2500/3)) \
                               .withColumn("carb_percentage", calc_percentage("carb", 130/3)) \
                               .withColumn("protein_percentage", calc_percentage("protein", 60/3)) \
                               .withColumn("fat_percentage", calc_percentage("fat", 51/3))

# 각 퍼센티지에서 100을 뺀 절대값을 계산
recommendation_df = recommendation_df.withColumn("abs_diff_kcal", abs(col("kcal_percentage") - 100)) \
                                     .withColumn("abs_diff_carb", abs(col("carb_percentage") - 100)) \
                                     .withColumn("abs_diff_protein", abs(col("protein_percentage") - 100)) \
                                     .withColumn("abs_diff_fat", abs(col("fat_percentage") - 100))

# 표준 편차 계산 후 소수점 셋째자리에서 반올림
recommendation_df = recommendation_df.withColumn("stddev_percentage",
                                                round((col("abs_diff_kcal") + col("abs_diff_carb") + col("abs_diff_protein") + col("abs_diff_fat")) / 4, 2))

# 표준 편차가 작은 순으로 정렬
recommended_foods = recommendation_df.orderBy("stddev_percentage").limit(500)

# 나트륨 총량 계산
single_recommended_food = recommended_foods.collect()[0]
sodium_cnt = selected_food["sodium"] + single_recommended_food.sodium

# 추천된 음식과 각 항목별 퍼센티지 출력
recommended_foods.select("product_name", "kcal_percentage", "carb_percentage", "protein_percentage", "fat_percentage", "stddev_percentage").show()

# 처리 시간 계산 및 출력
end_time = time.time()
processing_time = end_time - start_time
print(f"처리 시간: {processing_time} 초")
print(f"나트륨 함량은 {sodium_cnt} 입니다.")

# 나트륨 총량 체크
if sodium_cnt > 2000:
    print("나트륨 함량이 너무 높습니다.")

# Spark 세션 종료
spark.stop()