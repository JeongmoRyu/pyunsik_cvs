import pandas as pd

# 가정: 'convAllProduct.csv'과 'DBAllproduct2.csv' 두 개의 CSV 파일이 이미 존재함
conv_df = pd.read_csv("숫자다삭제.csv", encoding="cp949")
db_df = pd.read_csv("DBAllproduct.csv", encoding="cp949")

# 빈 MixProduct 데이터프레임 생성
columns = ['상품명', '카테고리', '가격', '행사 정보', '중량', '칼로리', '탄수화물', '단백질', '지방', '나트륨', '편의점 코드', '이미지 주소']
dtypes = {
    '상품명': 'object',
    '카테고리': 'object',
    '가격': 'float64',
    '행사 정보': 'object',
    '중량': 'float64',
    '칼로리': 'float64',
    '탄수화물': 'float64',
    '단백질': 'float64',
    '지방': 'float64',
    '나트륨': 'float64',
    '편의점 코드': 'object',
    '이미지 주소': 'object'
}

mix_df = pd.DataFrame(columns=columns).astype(dtypes)

# 상품명 비교 및 데이터 병합
for index, conv_row in conv_df.iterrows():
    matched_row = db_df.loc[db_df['상품명'] == conv_row['상품명']]
    if not matched_row.empty:
        new_row = pd.DataFrame([{
            '상품명': conv_row['상품명'],
            '가격': conv_row['가격'],
            '행사 정보': conv_row['행사 정보'],
            '편의점 코드': conv_row['편의점 코드'],
            '이미지 주소': conv_row['이미지 주소'],
            '카테고리': matched_row.iloc[0]['카테고리'],
            '중량': matched_row.iloc[0]['중량'],
            '칼로리': matched_row.iloc[0]['칼로리'],
            '탄수화물': matched_row.iloc[0]['탄수화물'],
            '단백질': matched_row.iloc[0]['단백질'],
            '지방': matched_row.iloc[0]['지방'],
            '나트륨': matched_row.iloc[0]['나트륨']
        }], columns=columns)

        mix_df = pd.concat([mix_df, new_row], ignore_index=True)

# 결과를 'MixProduct.csv'에 저장
print("매칭완료2")
mix_df.to_csv("MixProduct2.csv", index=False, encoding="cp949")
