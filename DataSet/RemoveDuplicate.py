import pandas as pd

# productDB.csv 파일 읽어오기
df = pd.read_csv("productDBcsv.csv", encoding='cp949')
# 중복된 상품명과 중량 제거
df.drop_duplicates(subset=['상품명', '중량','칼로리'], keep='first', inplace=True)
# 결과를 파일로 저장 (productNoDuplicated.csv)
df.to_csv('productNoDuplicated.csv', index=False, encoding='cp949')
print("productNoDuplicated.csv 파일이 생성 완료.")