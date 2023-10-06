import pandas as pd
import re
import dask.dataframe as dd
from dask.distributed import Client
from dask import delayed, compute

# Initialize Dask client for distributed computing
client = Client()

conv_all_product = pd.read_csv('ConvAllProduct.csv', encoding='cp949')
db_all_product = pd.read_csv('DBAllproduct.csv', encoding='cp949')

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

# 유사도 계산을 위한 함수
def calculate_similarity(row1, row2):
    common_tokens = len(row1['TokenizedName'].intersection(row2['TokenizedName']))
    if len(row1['TokenizedName']) == 0:
        return 0
    return common_tokens / len(row1['TokenizedName'])

# Dask DataFrames로 변환
conv_all_product_dd = dd.from_pandas(conv_all_product, npartitions=64)
db_all_product_dd = dd.from_pandas(db_all_product, npartitions=64)

# 분산 처리를 위한 함수
@delayed
def process_partition(conv_partition, db_partition):
    similar_products_partition = []

    for i, row1 in conv_partition.iterrows():
        for j, row2 in db_partition.iterrows():
            similarity = calculate_similarity(row1, row2)

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
                    similar_products_partition.append(merged_row)

    return pd.DataFrame(similar_products_partition)

# 분산 처리 시작
results = []
for i in range(8):  # Adjust the number of partitions as needed
    results.append(process_partition(conv_all_product_dd.get_partition(i),
                                      db_all_product_dd.get_partition(i)))

# 결과를 계산
similar_products_list = compute(*results, scheduler='threads')[0]

# 결과를 DataFrame으로 변환 및 중복 제거
result_df = pd.DataFrame(similar_products_list).drop_duplicates()

# 결과를 CSV 파일로 저장
result_df.to_csv('ReducedProduct.csv', encoding='cp949', index=False)

# Dask 클라이언트 종료
client.close()