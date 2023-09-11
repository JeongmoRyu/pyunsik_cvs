from selenium.common.exceptions import StaleElementReferenceException, TimeoutException, \
    ElementClickInterceptedException
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import undetected_chromedriver as uc
import csv
import time

# 대기 시간 3초 (필요에 따라 조절)
LOADING_WAIT_TIME = 3

# 크롤링할 상품 코드
pcodes = ['1&align=', '2&align=']
# pcodes = ['depth3=2']
# 결과 딕셔너리
product_data = dict()
pagecnt = 1

def crawl():
    product_elements = driver.find_elements(By.CLASS_NAME, 'itemWrap')
    for product_element in product_elements:
        name_element = product_element.find_element(By.CLASS_NAME, 'itemtitle')
        price_element = product_element.find_element(By.CLASS_NAME, 'price')
        img_element = product_element.find_element(By.TAG_NAME, 'img')

        # 첫번째 크롤링이면 1+1, 두번째면 2+1
        span_class = ""
        if pagecnt == 1:
            span_class = "onepl floatR"
        elif pagecnt == 2:
            span_class = "twopl floatR"

        # ) 이 들어가있지 않은 상품은 전체를 가져와야함   참치도시락   라)참깨라면
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

        # 행사 정보 초기값을 빈 문자열로 설정
        badge_text = ""

        # 행사 정보 확인
        if span_class == "onepl floatR":
            badge_text = "ONE_PLUS_ONE"
        elif span_class == "twopl floatR":
            badge_text = "TWO_PLUS_ONE"

        # 딕셔너리에 상품 이름, 가격, 이미지 주소, 행사 정보 추가
        if product_name not in product_data:
            product_data[product_name] = {'가격': product_price, '행사 정보': badge_text, '이미지 주소': product_img_src}
        else:
            # 이미 상품이 딕셔너리에 있는 경우, 가격과 이미지 주소 업데이트
            product_data[product_name]['가격'] = product_price
            product_data[product_name]['행사 정보'] = badge_text
            product_data[product_name]['이미지 주소'] = product_img_src

def init_driver():
    driver = uc.Chrome(use_subprocess=True, auto_quit=False)
    return driver

def find_product(pcode, driver):
    global cnt
    url = f'https://www.emart24.co.kr/goods/event?search=&category_seq={pcode}'
    driver.get(url)

    while True:
        # 로딩시간 때문에 5초정도 기다려야함
        time.sleep(5)
        crawl()
        try:
            next_button = WebDriverWait(driver, LOADING_WAIT_TIME).until(
                EC.presence_of_element_located(
                    (By.XPATH, '/html/body/div[2]/div/div/div[2]/div[1]/img'))
            )
            next_button.click()
            # 다음 버튼을 클릭한 후 화면 변화를 기다림
            WebDriverWait(driver, LOADING_WAIT_TIME).until(
                EC.staleness_of(next_button)
            )
        except StaleElementReferenceException:
            continue
        except TimeoutException:
            # 다음 페이지 로딩을 기다렸지만 타임아웃 발생 시 종료. 마지막 페이지라고 추정됨.
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
    with open('emart.csv', 'w', newline='') as csvfile:
        fieldnames = ['상품명', '가격', '행사 정보', '이미지 주소']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()

        for pcode in pcodes:
            find_product(pcode, driver)
            pagecnt += 1

        for name, data in product_data.items():
            writer.writerow({'상품명': name, '가격': data['가격'], '행사 정보': data['행사 정보'], '이미지 주소': data['이미지 주소'] })

    # 웹 드라이버 종료
    driver.quit()