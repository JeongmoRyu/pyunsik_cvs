import pandas as pd

# 합쳐.csv 파일 읽기
df = pd.read_csv('합쳐.csv', encoding='cp949')

# 새로운 총중량(g) 컬럼 생성
df['총중량(g)'] = None

# 각 행에 대하여
for idx, row in df.iterrows():
    if row['총내용량(g)'] != '-':
        df.at[idx, '총중량(g)'] = row['총내용량(g)']
    elif row['총내용량(mL)'] != '-':
        df.at[idx, '총중량(g)'] = row['총내용량(mL)']

# 총중량(g) 컬럼에 숫자만 남게 함
df['총중량(g)'] = pd.to_numeric(df['총중량(g)'], errors='coerce')

# 합쳤어.csv로 저장
df.to_csv('합쳤어.csv', index=False, encoding='cp949')
print("끝났어용")