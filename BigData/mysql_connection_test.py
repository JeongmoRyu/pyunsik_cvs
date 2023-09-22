#!/usr/bin/env python
# coding: utf-8

# In[15]:


#get_ipython().system('pip3 install mysql-connector')
#get_ipython().system('pip3 install mysql-connector-python')
#get_ipython().system('pip3 install PyMySQL')


# In[22]:


import pymysql

try:
    connection = pymysql.connect(
        host='192.168.231.129',
        port=3306,
        user='a',
        password='ssafy',
        db='SparkTest',
        cursorclass=pymysql.cursors.DictCursor
    )
    
    if connection.open:
        print("db 연결됨")
        
except Exception as e:
    print(f"Error: {e}")

finally:
    connection.close()
    print("db 연결 해제")

