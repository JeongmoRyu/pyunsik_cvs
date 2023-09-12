#!/usr/bin/env python
# coding: utf-8

# In[1]:


#get_ipython().system('pip3 install redis')


# In[12]:


from pyspark.sql import SparkSession
from pyspark.sql.functions import *
import redis
import json

# Spark 세션 초기화
spark = SparkSession \
    .builder \
    .appName("RealTimeSearch") \
    .config("spark.driver.extraClassPath", "/usr/local/spark/myjars/mysql-connector-j-8.1.0.jar") \
    .getOrCreate()

# MySQL에서 데이터 읽기
jdbc_url = "jdbc:mysql://192.168.231.129:3306/SparkTest"  # IP와 포트를 자신의 환경에 맞게 수정
properties = {
    "user": "a",  # MySQL 사용자 이름
    "password": "ssafy",  # MySQL 비밀번호
    "driver": "com.mysql.cj.jdbc.Driver",
}

# 오늘 날짜의 검색 로그만 가져오기
query = "(SELECT * FROM searchlog WHERE DATE(created_at) = CURDATE()) as searchlog"
df = spark.read \
    .jdbc(jdbc_url, query, properties=properties)

# 실시간 검색어 처리: 단어별로 카운트
search_keywords = df.groupBy("keyword").count().orderBy(desc("count"))

search_keywords.show()

# Redis 연결 설정
#r = redis.Redis(host='localhost', port=6379, db=0)  # Redis 호스트와 포트를 자신의 환경에 맞게 수정

# DataFrame을 JSON으로 변환 후 Redis에 저장
search_json = json.dumps(search_keywords.toJSON().collect())
#r.set('realtime_search_keywords', search_json)

# Redis에서 데이터 확인 (테스트용)
#print(r.get('realtime_search_keywords').decode('utf-8'))

