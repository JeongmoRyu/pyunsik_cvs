import pymysql

# 데이터베이스 연결
conn = pymysql.connect(
    host='j9a505a.p.ssafy.io',
    port=3308,
    user='root',
    password='gndhqkd123',
    db='business',
    charset='utf8mb4'
)

print("실행시작")
# 커서 생성
cursor = conn.cursor()

# con_id가 5인 행을 모두 가져온다.
cursor.execute("SELECT * FROM convenience_info WHERE convenience_code = 5")
rows = cursor.fetchall()

# 가져온 행을 기반으로 새로운 행을 생성하고 con_id를 1, 2, 3, 4로 설정한다.
new_con_ids = [1, 2, 3, 4]
for row in rows:
    for new_con_id in new_con_ids:
        cursor.execute("INSERT INTO convenience_info (product_id, convenience_code, promotion_code) VALUES (%s, %s, %s)", (row[1], new_con_id, row[3]))

# con_id가 5인 원래의 행을 삭제한다.
cursor.execute("DELETE FROM convenience_info WHERE convenience_code = 5")

# 변경사항을 데이터베이스에 반영한다.
conn.commit()

# 데이터베이스 연결을 닫는다.
conn.close()
print("실행 종료 완료")