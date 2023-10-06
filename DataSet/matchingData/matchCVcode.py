import pandas as pd

conv_all_product = pd.read_csv('ConvAllProduct.csv',encoding='cp949')
manual_work = pd.read_csv('수작업.csv',encoding='cp949')
merged_df = pd.merge(conv_all_product, manual_work, on='이미지 주소', how='left')
merged_df['편의점 코드_x'].update(merged_df['편의점 코드_y'])
result_df = merged_df[['이미지 주소', '편의점 코드_x']]
result_df.to_csv('결과.csv', index=False,encoding='cp949')
