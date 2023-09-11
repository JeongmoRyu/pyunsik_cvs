from selenium.common.exceptions import StaleElementReferenceException, TimeoutException, \
    ElementClickInterceptedException, ElementNotInteractableException
from selenium.webdriver import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import undetected_chromedriver as uc
import csv
import time

# 대기 시간 3초 (필요에 따라 조절)
LOADING_WAIT_TIME = 3
cnt = 0
# 결과 딕셔너리
product_data = dict()

def init_driver():
    driver = uc.Chrome(use_subprocess=True, auto_quit=False)
    return driver

def find_product(driver):
    global cnt
    url = f'https://www.7-eleven.co.kr/product/presentList.asp'
    driver.get(url)

    if cnt != 0:
        # 2+1 버튼이 나타날 때까지 스크롤을 위로 올림
        while True:
            try:
                seven_exclusive_button = driver.find_element(By.XPATH, '//a[contains(text(), "2+1")]')
                seven_exclusive_button.click()
                break
            except:
                # 스크롤을 위로 올림
                driver.find_element(By.TAG_NAME, 'body').send_keys(Keys.PAGE_UP)
                time.sleep(0.5)  # 0.5초 대기, 필요에 따라 조정 가능

    # 처음 more 버튼은 path가 다르다.
    first_more_button = WebDriverWait(driver, LOADING_WAIT_TIME).until(
        EC.presence_of_element_located(
            (By.XPATH, '//*[@id="listUl"]/li[15]/a'))
    )
    first_more_button.click()

    while True:
        try:
            more_button = WebDriverWait(driver, LOADING_WAIT_TIME).until(
                EC.presence_of_element_located((By.XPATH, '//*[@id="moreImg"]/a'))
            )
            more_button.click()
            cnt += 1
            # print("{}번 째 more버튼을 클릭했습니다.".format(cnt))

        except StaleElementReferenceException:
            print("StaleElement 에러발생!")
            break
        except TimeoutException:
            print("Timeout 에러발생!")
            break
        except ElementNotInteractableException:  # 추가한 예외 처리
            print("ElementNotInteractableException 발생!")
            break
        except ElementClickInterceptedException:
            print("Element Click Interceptor 에러발생!")
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
        time.sleep(2)

    # print("more 버튼 클릭이 잘 종료되었습니다.")
    product_elements = driver.find_elements(By.CLASS_NAME, 'pic_product')
    for product_element in product_elements:
        # print("엘리멘트들을 가져오기위해 진입했습니다.")
        name_element = product_element.find_element(By.CLASS_NAME, 'name')
        # print("이름 가져왔음")
        price_element = product_element.find_element(By.CLASS_NAME, 'price')
        # print("가격 가져왔음")
        img_element = product_element.find_element(By.TAG_NAME, 'img')
        # print("이미지 가져왔음")

        try:
            badge_element = product_element.find_element(By.CLASS_NAME, 'tag_list_01')
            span_element = badge_element.find_element(By.TAG_NAME, 'li')
            span_class = span_element.get_attribute('class')
        except:
            # print("badge를 잘 못찾았어요.")
            # 첫 크롤링일 때는 1+1이고
            if cnt == 0:
                span_class = "ico_tag_06"
            else:
                #그 다음 크롤링은 2+1이다.
                span_class = "ico_tag_07"

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

        product_price = price_element.text
        product_img_src = img_element.get_attribute('src')

        # 행사 정보 초기값을 빈 문자열로 설정
        badge_text = ""

        # 행사 정보 확인
        if span_class == "ico_tag_07":
            badge_text = "TWO_PLUS_ONE"
        elif span_class == "ico_tag_06":
            badge_text = "ONE_PLUS_ONE"

        # 딕셔너리에 상품 이름, 가격, 이미지 주소, 행사 정보 추가
        if product_name not in product_data:
            product_data[product_name] = {'가격': product_price, '행사 정보': badge_text, '이미지 주소': product_img_src}
        else:
            # 이미 상품이 딕셔너리에 있는 경우, 가격과 이미지 주소 업데이트
            product_data[product_name]['가격'] = product_price
            product_data[product_name]['행사 정보'] = badge_text
            product_data[product_name]['이미지 주소'] = product_img_src



if __name__ == "__main__":
    driver = init_driver()
    with open('seveneleven.csv', 'w', newline='') as csvfile:
        fieldnames = ['상품명', '가격','행사 정보', '이미지 주소']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        find_product(driver)
        cnt += 1
        find_product(driver)
        for name, data in product_data.items():
            writer.writerow({'상품명': name, '가격': data['가격'], '행사 정보': data['행사 정보'], '이미지 주소': data['이미지 주소'] })
    driver.quit()
driver.quit()