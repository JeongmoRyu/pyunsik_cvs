from pyspark.sql import SparkSession
from pyspark.sql.functions import col, abs
import time

# Spark 세션 초기화
spark = SparkSession \
    .builder \
    .appName("FoodRecommendation") \
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

query = "(SELECT category, product_name, kcal, carb, protein, fat, sodium FROM FinalData) as FinalData"
df = spark.read.jdbc(jdbc_url, query, properties=properties)

# 현재 선택한 음식의 정보 (예시)
selected_food = {
    "category": "selected_category",
    "product_name": "selected_product_name",  # 선택한 음식의 이름을 여기에 입력하세요
    "kcal": 767,
    "carb": 105,
    "protein": 28,
    "fat": 21,
    "sodium": 667
}

print(f"선택한 음식: {selected_food['product_name']}")

# 현재 선택한 카테고리를 제외하고 데이터 필터링
filtered_df = df.filter(df.category != selected_food["category"])

# 각 항목별 권장량과의 차이 계산
def calc_difference(column_name, recommended_value):
    return abs(df[column_name] + selected_food[column_name] - recommended_value)

recommendation_df = filtered_df.withColumn("kcal_diff", calc_difference("kcal", 767)) \
                               .withColumn("carb_diff", calc_difference("carb", 105)) \
                               .withColumn("protein_diff", calc_difference("protein", 28)) \
                               .withColumn("fat_diff", calc_difference("fat", 21)) \
                               .withColumn("sodium_diff", calc_difference("sodium", 667))

# 차이의 합계를 계산
recommendation_df = recommendation_df.withColumn("total_difference",
                                                recommendation_df["kcal_diff"] +
                                                recommendation_df["carb_diff"] +
                                                recommendation_df["protein_diff"] +
                                                recommendation_df["fat_diff"] +
                                                recommendation_df["sodium_diff"])

# 차이의 합계가 가장 작은 음식 10개 찾기
recommended_foods = recommendation_df.orderBy("total_difference").limit(500)

# 추천된 음식과 각 항목별 차이 출력
recommended_foods.select("product_name", "kcal_diff", "carb_diff", "protein_diff", "fat_diff", "sodium_diff").show()

# 처리 시간 계산 및 출력
end_time = time.time()
processing_time = end_time - start_time
print(f"Processing time: {processing_time} 초")

# Spark 세션 종료
spark.stop()