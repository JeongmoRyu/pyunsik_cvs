import pandas as pd

# all.csv와 combinedFixed.csv 파일 읽어오기
all_df = pd.read_csv("all.csv", encoding='cp949')
combined_fixed_df = pd.read_csv("combinedFixed.csv", encoding='cp949')
# 중복 상품명을 기준으로 중복 제거
all_df = all_df.drop_duplicates(subset=["상품명"], keep=False)
# combinedFixed에 없는 상품명과 편의점 코드 5를 추가
combined_fixed_df = pd.concat([combined_fixed_df, all_df[~all_df['상품명'].isin(combined_fixed_df['상품명'])]])
combined_fixed_df["편의점 코드"].fillna(5, inplace=True)
# 행사 정보 열의 값을 변경
combined_fixed_df["행사 정보"] = combined_fixed_df["행사 정보"].str.replace("TWO_PLUS_ONE", "2+1")
combined_fixed_df["행사 정보"] = combined_fixed_df["행사 정보"].str.replace("ONE_PLUS_ONE", "1+1")
# finalCombined.csv로 저장
combined_fixed_df.to_csv("finalCombined.csv",encoding='cp949',index=False)
print("finalCombined.csv 파일 생성 완료.")