import pandas as pd
import re

conv_all_product = pd.read_csv('ConvAllProduct.csv', encoding='cp949')
db_all_product = pd.read_csv('DBAllproduct.csv', encoding='cp949')
cnt = 0

# 상품명 전처리
def process_name(name):
    if pd.isna(name):
        return ""
    match = re.search(r'\d', name)
    if match:
        index = match.start()
        if len(name[index:]) > 2:
            return name
        else:
            return name[:index]
    return name


# 상품명을 토큰화하는 함수
def tokenize_name(name):
    return set(name.split(' '))


# 상품명 전처리
conv_all_product['ProcessedName'] = conv_all_product['상품명'].apply(process_name)
db_all_product['ProcessedName'] = db_all_product['상품명'].apply(process_name)

# 상품명을 토큰화
conv_all_product['TokenizedName'] = conv_all_product['ProcessedName'].apply(tokenize_name)
db_all_product['TokenizedName'] = db_all_product['ProcessedName'].apply(tokenize_name)

# 결과를 저장할 리스트와 중복 처리를 위한 set을 생성
similar_products_list = []
unique_products_set = set()

# 유사도 계산 및 저장
for i, row1 in conv_all_product.iterrows():
    for j, row2 in db_all_product.iterrows():
        common_tokens = len(row1['TokenizedName'].intersection(row2['TokenizedName']))
        if len(row1['TokenizedName']) == 0:
            continue
        similarity = common_tokens / len(row1['TokenizedName'])

        if similarity >= 0.8:
            unique_key = f"{row1['ProcessedName']}_{row2['ProcessedName']}"
            if unique_key not in unique_products_set:
                unique_products_set.add(unique_key)
                merged_row = {
                    '상품명': row1['ProcessedName'],
                    '카테고리': row2['카테고리'],
                    '중량': row2['중량'],
                    '칼로리': row2['칼로리'],
                    '단백질': row2['단백질'],
                    '지방': row2['지방'],
                    '탄수화물': row2['탄수화물'],
                    '나트륨': row2['나트륨'],
                    '가격': row1['가격'],
                    '행사 정보': row1['행사 정보'],
                    '이미지 주소': row1['이미지 주소']
                }
                similar_products_list.append(merged_row)

    cnt += 1
    print("{} 번 째 작업 실행중".format(cnt))

# 결과를 DataFrame으로 변환 및 중복 제거
result_df = pd.DataFrame(similar_products_list).drop_duplicates()
result_df.to_csv('SimilarMixedProduct.csv', encoding='cp949', index=False)