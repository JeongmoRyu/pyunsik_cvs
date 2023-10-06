import redis
from pyspark.sql import SparkSession
from pyspark.sql.functions import count, desc

# Spark 세션 초기화
spark = SparkSession \
    .builder \
    .appName("PopularProductsByCategory") \
    .config("spark.driver.extraClassPath", "/usr/local/spark/myjars/mysql-connector-j-8.1.0.jar") \
    .getOrCreate()

# MySQL에서 데이터 읽기
jdbc_url = "jdbc:mysql://j9a505a.p.ssafy.io:3308/business"
properties = {
    "user": "root",
    "password": "gndhqkd123",
    "driver": "com.mysql.cj.jdbc.Driver",
}

# MySQL에서 favorite 테이블 읽어오기
query_fav = "(SELECT * FROM favorite WHERE is_deleted=0) as favorite"
df_fav = spark.read \
    .jdbc(jdbc_url, query_fav, properties=properties)

# MySQL에서 product 테이블 읽어오기
query_prod = "(SELECT * FROM product WHERE is_deleted=0) as product"
df_prod = spark.read \
    .jdbc(jdbc_url, query_prod, properties=properties)

# favorite 테이블을 product_id로 그룹화하고 카운트
df_fav_grouped = df_fav.groupBy("product_id").agg(count("id").alias("favorite_count"))

# 'product_id' 컬럼 이름을 'id'로 바꾸기
df_fav_grouped = df_fav_grouped.withColumnRenamed("product_id", "id")

# product 테이블과 favorite 테이블 조인
df_joined = df_prod.join(df_fav_grouped, "id", "left_outer").fillna(0)

# Redis 연결 설정
r = redis.Redis(host='j9a505a.p.ssafy.io', port=6382, db=0)

# 모든 카테고리 가져오기
all_categories = df_prod.select("category").distinct().collect()

for row in all_categories:
    category = row.category
    if category is not None:
        df_filtered = df_joined.filter(df_joined.category == category)
        df_top10 = df_filtered.orderBy(desc("favorite_count")).limit(10)
        
        top10_list = [row.id for row in df_top10.collect()]
        
        redis_key = f"popular_products:{category}"
        r.set(redis_key, str(top10_list))

# Spark 세션 종료
spark.stop()
