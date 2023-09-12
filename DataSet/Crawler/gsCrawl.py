from selenium.common.exceptions import StaleElementReferenceException, TimeoutException, \
    ElementClickInterceptedException
from selenium.webdriver import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import undetected_chromedriver as uc
import csv
import time

# 대기 시간 3초 (필요에 따라 조절)
LOADING_WAIT_TIME = 3
# 결과 딕셔너리
product_data = dict()
cnt = 0

def init_driver():
    driver = uc.Chrome(use_subprocess=True, auto_quit=False)
    return driver
def crawl():
    product_elements = driver.find_elements(By.CLASS_NAME, 'prod_box')
    for product_element in product_elements:
        name_element = product_element.find_element(By.CLASS_NAME, 'tit')
        price_element = product_element.find_element(By.CLASS_NAME, 'price')
        img_element = product_element.find_element(By.TAG_NAME, 'img')
        event = ""  # 변수 초기화
        flag_box = product_element.find_element(By.CLASS_NAME, "flag_box")
        if "ONE_TO_ONE" in flag_box.get_attribute("class"):
            event = "ONE_PLUS_ONE"
        elif "TWO_TO_ONE" in flag_box.get_attribute("class"):
            event = "TWO_PLUS_ONE"

        # ) 이 들어가있지 않은 상품은 전체를 가져와야함
        if ')' in name_element.text:
            # )가 들어가있기는 한테 마지막 글자가 )면 글자 전체를 가져와야 함 ex) 포켓몬 카드울트라(문)
            if name_element.text[-1] == ')' and name_element.text.count(')') == 1:
                product_name = name_element.text
                # 그렇지 않으면 처음 )가 등장한 다음 index부터 가져오면 됨 ex) 삼앙)오레오라면 -> 오레오라면 , 도시락)혜자도시락 -> 혜자도시락
            else:
                product_name = name_element.text[name_element.text.index(')') + 1:]
        else:
            product_name = name_element.text

        product_price = price_element.text[:-1]
        product_img_src = img_element.get_attribute('src')

        # 딕셔너리에 상품 이름, 가격, 이미지 주소, 행사 정보 추가
        if product_name not in product_data:
            product_data[product_name] = {'가격': product_price, '행사 정보': event, '이미지 주소': product_img_src}
        else:
            # 이미 상품이 딕셔너리에 있는 경우, 가격과 이미지 주소 업데이트
            product_data[product_name]['가격'] = product_price
            product_data[product_name]['행사 정보'] = event
            product_data[product_name]['이미지 주소'] = product_img_src

# 이전 'on' 클래스 값을 저장하는 변수

def find_product(driver):
    global cnt
    url = f'http://gs25.gsretail.com/gscvs/ko/products/event-goods'
    driver.get(url)

    # 전체 버튼이 나타날 때까지 스크롤을 위로 올림
    while True:
        try:
            gs_exclusive_button = driver.find_element(By.XPATH, '//a[contains(text(), "전체")]')
            gs_exclusive_button.click()
            break
        except:
            # 스크롤을 위로 올림
            driver.find_element(By.TAG_NAME, 'body').send_keys(Keys.PAGE_DOWN)
            time.sleep(0.5)  # 0.5초 대기, 필요에 따라 조정 가능

    # 우선 마지막 페이지로 이동한 후에 앞으로 이동하면서
    final_button = WebDriverWait(driver, LOADING_WAIT_TIME).until(
        EC.presence_of_element_located(
            (By.XPATH, '//*[@id="wrap"]/div[4]/div[2]/div[3]/div/div/div[4]/div/a[4]'))
    )
    final_button.click()

    while True:
        #로딩시간 때문에 5초정도 기다려야함
        time.sleep(5)
        crawl()

        #크롤링을 진행했고, 현재 페이지가 1페이지면 종료해야함
        current_page_element = driver.find_element(By.CSS_SELECTOR,
                                                   '#wrap > div.cntwrap > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(9) > div > span > a.on')
        current_page = int(current_page_element.text)  # 텍스트를 정수로 변환
        if current_page == 1:
            print("현재 페이지가 1페이지입니다. 크롤링을 종료합니다.")
            break
        try:
            previous_button = WebDriverWait(driver, LOADING_WAIT_TIME).until(
                EC.presence_of_element_located(
                    (By.XPATH, '//*[@id="wrap"]/div[4]/div[2]/div[3]/div/div/div[4]/div/a[2]'))
            )
            previous_button.click()
        except StaleElementReferenceException:
            continue
        except TimeoutException:
            break
        except ElementClickInterceptedException:
            # 클릭을 가로채는 요소가 있을 때 예외 처리
            # 겹치는 요소가 사라질 때까지 대기
            try:
                WebDriverWait(driver, LOADING_WAIT_TIME).until(
                    EC.invisibility_of_element_located((By.XPATH, '//*[@id="overlay"]'))
                )
            except TimeoutException:
                # 대기 시간이 초과될 경우 예외 처리 (예: 오버레이가 사라지지 않을 때)
                print("오버레이가 에러")
            continue


if __name__ == "__main__":
    driver = init_driver()

    # Open the CSV file for writing outside the loop
    with open('gs.csv', 'w', newline='') as csvfile:
        fieldnames = ['상품명', '가격', '행사 정보', '이미지 주소']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        find_product(driver)

        # Write the data to the CSV file within the loop
        for name, data in product_data.items():
            writer.writerow({'상품명': name, '가격': data['가격'], '행사 정보': data['행사 정보'], '이미지 주소': data['이미지 주소']})

    # 웹 드라이버 종료
    driver.quit()
