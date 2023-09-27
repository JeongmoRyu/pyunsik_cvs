import pandas as pd
import requests

df = pd.read_csv("CombinedDuplicatedProduct.csv", encoding='cp949')

# 이미 저장된 상품명을 추적하기 위한 리스트
saved_products = []
# 저장하지 못한 상품명을 저장하기 위한 리스트
failed_products = []

# csv에서 이미지 url , 상품명 가져옴
for index, row in df.iterrows():
    product_name = row['상품명']
    image_url = row['이미지 주소']

    # 중복되지 않으면 다운로드
    if product_name not in saved_products:
        try:
            response = requests.get(image_url)
            with open(f"{product_name}.jpg", 'wb') as f:
                f.write(response.content)

            print(f"'{product_name}'을 저장했습니다.")

            # 중복 저장을 위한 이름 리스트 append
            saved_products.append(product_name)
        except:
            # 저장하지 못한 상품명을 리스트에 추가
            failed_products.append(product_name)

print("모든 작업이 완료되었습니다.")
# 저장하지 못한 상품명을 출력
if len(failed_products) > 0:
    print("저장하지 못한 상품들:")
    for product in failed_products:
        print(product)