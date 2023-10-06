import pandas as pd

# 각 CSV 파일을 데이터프레임으로 읽어오기
gs_df = pd.read_csv("gs.csv", encoding='cp949')
cu_df = pd.read_csv("cu.csv", encoding='cp949')
seveneleven_df = pd.read_csv("seveneleven.csv", encoding='cp949')
emart_df = pd.read_csv("emart.csv", encoding='cp949')
all_df = pd.read_csv("all.csv", encoding='cp949')

# "편의점 코드" 열 추가 및 값 채우기
gs_df["편의점 코드"] = 1
cu_df["편의점 코드"] = 2
seveneleven_df["편의점 코드"] = 3
emart_df["편의점 코드"] = 4
all_df["편의점 코드"] = 5

# 데이터프레임을 합치기
combined_df = pd.concat([gs_df, cu_df, seveneleven_df, emart_df, all_df])

# 인덱스를 다시 설정
combined_df.reset_index(drop=True, inplace=True)

# 합쳐진 데이터프레임을 CSV 파일로 저장
combined_df.to_csv("combined.csv", encoding='cp949', index=False)
print("combined.csv 파일이 생성 완료.")