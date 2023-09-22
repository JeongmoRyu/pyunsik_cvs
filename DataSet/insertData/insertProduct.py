import pymysql
import pandas as pd
from dotenv import load_dotenv
import os

# .env 파일에서 환경 변수 로드
load_dotenv()

# 환경 변수 읽기
host = os.getenv("DB_HOST")
port = int(os.getenv("DB_PORT"))  # 정수로 변환
user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
db = os.getenv("DB_NAME")

# 환경 변수를 사용하여 데이터베이스 연결
def connect_db():
    return pymysql.connect(
        host=host,
        port=port,
        user=user,
        password=password,
        db=db,
        charset='utf8mb4'
    )


# 특정 편의점 코드에 해당하는 데이터만 CSV 파일에서 읽어오는 함수
def read_csv_data(store_code):
    csv_path = "CombinedDuplicatedProduct.csv"  # 실제 파일 경로를 입력하세요.
    df = pd.read_csv(csv_path, encoding='cp949')  # cp949 인코딩으로 CSV 파일 읽기
    return df[df['편의점 코드'] == store_code]  # 편의점 코드에 해당하는 데이터만 필터링하여 반환


# 메인 함수
def main():
    conn = connect_db()  # 데이터베이스 연결
    cursor = conn.cursor()  # 커서 생성
    store_order = [5, 2, 1, 3, 4]  # 편의점 코드 순서

    # 편의점 코드 순서대로 데이터 처리
    for store_code in store_order:
        products = read_csv_data(store_code)  # 편의점 코드에 해당하는 데이터 읽기

        # 읽어온 데이터를 행 단위로 처리
        for _, product in products.iterrows():
            # 문자열에서 쉼표 제거 및 타입 변환

            price = int(str(product['가격']).replace(',', ''))
            kcal = int(str(product['칼로리']).replace(',', ''))
            carb = float(str(product['탄수화물']).replace(',', ''))
            protein = float(str(product['단백질']).replace(',', ''))
            fat = float(str(product['지방']).replace(',', ''))

            product_name = product['상품명']  # 상품명
            print("{} 을 넣고있습니다.".format(product_name))

            # 중복 상품명 검사
            cursor.execute("SELECT id FROM product_temp WHERE product_name = %s", (product_name,))
            result = cursor.fetchone()

            if result:
                existing_product_id = result[0]
                # 중복 상품명이면 product_info 테이블에 데이터 삽입
                cursor.execute(
                    "INSERT INTO product_info (product_id, promotion_id, convenience_code) VALUES (%s, %s, %s)",
                    (existing_product_id, product.get('행사 정보', None), store_code))
            else:
                # 중복 상품명이 아니면 product_temp 테이블에 데이터 삽입
                cursor.execute(
                    "INSERT INTO product_temp (carb, category, fat, filename, is_deleted, kcal, price, product_name, protein, sodium, weight) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                    (carb, product['카테고리'], fat, product['이미지 주소'], 0, kcal, price, product['상품명'], protein,
                     product['나트륨'], product['중량']))

                new_product_id = cursor.lastrowid  # 삽입된 데이터의 ID 값 가져오기

                # 삽입된 데이터의 ID 값을 사용하여 product_info 테이블에 데이터 삽입
                cursor.execute(
                    "INSERT INTO product_info (product_id, promotion_id, convenience_code) VALUES (%s, %s, %s)",
                    (new_product_id, product.get('행사 정보', None), store_code))

            conn.commit()  # 데이터베이스에 변경 사항 반영


# 프로그램 시작점
if __name__ == "__main__":
    print("실행을 시작합니다.")
    main()
    print("실행이 정상적으로 종료됐습니다.")