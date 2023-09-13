import pandas as pd
from fuzzywuzzy import fuzz

# CSV 파일에서 데이터를 읽어옴
conv_df = pd.read_csv("ConvAllProduct2.csv", encoding='cp949')
db_df = pd.read_csv("DBAllproduct3.csv", encoding='cp949')

# 결과를 저장할 빈 데이터프레임을 생성
result_df = pd.DataFrame(columns=["ConvProduct", "DBProduct", "FuzzScore"])

# ConvAllProduct.csv의 상품명에 대해 DBAllproduct2.csv의 모든 상품명과 매칭을 시도
for conv_index, conv_row in conv_df.iterrows():
    conv_product = conv_row["상품명"]
    for db_index, db_row in db_df.iterrows():
        db_product = db_row["상품명"]

        # fuzz 점수를 계산
        score = fuzz.ratio(conv_product, db_product)

        # 점수가 85 이상이면 결과 데이터프레임에 저장
        if score >= 40:
            new_row = pd.DataFrame({
                "ConvProduct": [conv_product],
                "DBProduct": [db_product],
                "FuzzScore": [score]
            })
            result_df = pd.concat([result_df, new_row], ignore_index=True)

# 결과를 fuzz.csv로 저장합니다.
result_df.to_csv("fuzz2.csv", index=False, encoding='cp949')
