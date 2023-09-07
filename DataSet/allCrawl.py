from selenium.common.exceptions import StaleElementReferenceException, TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import undetected_chromedriver as uc
import csv

# 대기 시간 3초 (필요에 따라 조절)
LOADING_WAIT_TIME = 3

# 크롤링할 상품 코드
pcodes = ['depth3=1','depth3=2','depth3=3','depth3=4','depth3=5','depth3=6','depth3=7']

# 결과 딕셔너리
product_data = dict()

def init_driver():
    driver = uc.Chrome(use_subprocess=True, auto_quit=False)
    return driver

def find_review(pcode, driver):
    url = f'https://cu.bgfretail.com/product/product.do?category=product&depth2=4&{pcode}'
    driver.get(url)

    while True:
        try:
            more_button = WebDriverWait(driver, LOADING_WAIT_TIME).until(
                EC.presence_of_element_located((By.XPATH, '//a[contains(text(), "더보기")]'))
            )
            more_button.click()
        except StaleElementReferenceException:
            continue
        except TimeoutException:
            break

    product_elements = driver.find_elements(By.CLASS_NAME, 'prod_wrap')
    for product_element in product_elements:
        name_element = product_element.find_element(By.CLASS_NAME, 'name')
        price_element = product_element.find_element(By.CLASS_NAME, 'price')
        img_element = product_element.find_element(By.TAG_NAME, 'img')

        product_name = name_element.text[2:]
        product_price = price_element.text[:-1]
        product_img_src = img_element.get_attribute('src')

        # 딕셔너리에 상품 이름, 가격, 이미지 주소 추가
        if product_name not in product_data:
            product_data[product_name] = {'가격': product_price, '이미지 주소': product_img_src}
        else:
            # 이미 상품이 딕셔너리에 있는 경우, 가격과 이미지 주소 업데이트
            product_data[product_name]['가격'] = product_price
            product_data[product_name]['이미지 주소'] = product_img_src

if __name__ == "__main__":
    driver = init_driver()
    for pcode in pcodes:
        find_review(pcode, driver)

    # 결과 딕셔너리를 CSV 파일로 저장
    with open('저장.csv', 'w', newline='') as csvfile:
        fieldnames = ['상품명', '가격', '이미지 주소']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()
        for name, data in product_data.items():
            writer.writerow({'상품명': name, '가격': data['가격'], '이미지 주소': data['이미지 주소']})

    # 웹 드라이버 종료
    driver.quit()