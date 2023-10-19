## 📌 프로젝트 소개
<div align=center>
<img width=30% src="/assets/icon.png">
</div>

# 🥇삼성 주관 프로젝트 경진 최우수 프로젝트 선정🥇


### ✔️ 주제

건강한 편의점 조합 추천 앱

### ✔️ 주요 기능

1. 영양 성분 정보 제공
2. 나만의 조합 생성
3. 행사 상품 목록 제공
4. 추천 서비스
    1. 유저 기반 상품 추천
    2. 영양정보 기반 상품 추천
    3. 조합 기반 상품 추천
5. 실시간 인기 검색어 제공

### ✔️ 개발 기간

2023.08.28 - 2023.10.06

### ✔️ 사용 기술 스택

#### 사용 기술 스택

<div align="center">
<br>
<img src="https://img.shields.io/badge/springboot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white">
<img src="https://img.shields.io/badge/springsecurity-6DB33F?style=for-the-badge&logo=springsecurity&logoColor=white">
<img src="https://img.shields.io/badge/gradle-02303A?style=for-the-badge&logo=gradle&logoColor=white">
</br>

<br>
<img src="https://img.shields.io/badge/amazonec2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white">
<img src="https://img.shields.io/badge/amazons3-569A31?style=for-the-badge&logo=amazons3&logoColor=white">
<img src="https://img.shields.io/badge/firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white">
</br>
<br>
<img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
</br>

<br>
<img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
<img src="https://img.shields.io/badge/mongodb-47A248?style=for-the-badge&logo=mongodb&logoColor=white">
<img src="https://img.shields.io/badge/redis-DC382D?style=for-the-badge&logo=redis&logoColor=white">
<img src="https://img.shields.io/badge/apachekafka-231F20?style=for-the-badge&logo=apachekafka&logoColor=white">
</br>

<br>
<img src="https://img.shields.io/badge/docker-2496ED?style=for-the-badge&logo=docker&logoColor=white">
<img src="https://img.shields.io/badge/python-0052CC?style=for-the-badge&logo=python&logoColor=white">
<img src="https://img.shields.io/badge/apachespark-E25A1C?style=for-the-badge&logo=apachespark&logoColor=white">

</br>

<br>
<img src="https://img.shields.io/badge/intellijidea-000000?style=for-the-badge&logo=intellijidea&logoColor=white">
<img src="https://img.shields.io/badge/androidstudio-3DDC84?style=for-the-badge&logo=androidstudio&logoColor=white">

</br>
<div>
<img src="https://img.shields.io/badge/jira-0052CC?style=for-the-badge&logo=jira&logoColor=white">
<img src="https://img.shields.io/badge/figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white">
<img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white">
<img src="https://img.shields.io/badge/pandas-000000?style=for-the-badge&logo=pandas&logoColor=white">
<img src="https://img.shields.io/badge/selenium-43B02A?style=for-the-badge&logo=selenium&logoColor=white">


</div>
</div>



</aside>

### ✔️ 발표 자료

[ppt]

[편식합시다. - YouTube](https://www.youtube.com/watch?v=EsqhW0yHhcQ)

---

## 👥 팀원

### ✔️ FE

- 류정모
    - [FE] Figma를 활용한 목업 제작, Flutter를 활용한 편식 어플리케이션 개발,  UI/UX 설계, 데이터 크롤링 및 spark 분산 처리 예제 연습
      
---

## 🗂️ DOCS

### ✔️ 시스템 아키텍처

<img width=50% src="/assets/arc.png">

### ✔️ ER-Diagram

<img width=50% src="/assets/erd.png">


---

## 📱 UI/UX

### ✔️ Figma 목업


[편식 화면 설계도 Figma](https://www.figma.com/file/GxTwXO3ZQBauj2lkI0X8t6/%ED%99%94%EB%A9%B4-%EC%84%A4%EA%B3%84%EB%8F%84?type=design&node-id=0%3A1&mode=design&t=fsk9VuUYjyr0LKOS-1)

<img width=10% src="/assets/moooookup.gif">

```
- Figma 구현부터 Atomic Design을 이용하여 재사용성을 고려하여 원활하고 빠른 개발이 가능하도록 하였습니다.
- 목업 구현에서 깔끔하고 현재 사용되고 있을 법한 UX/UI를 구현하고자 하였습니다.
- 오늘의집, 토스, 다양한 편의점 어플 등 뿐 만 아니라 FatSecret, 등 해외 어플 등 실서비스 중인 어플들을 reference 삼아 사용자 편의성을 고려하였습니다.
- 또한 사용자 클릭 최소화하여 원하는 정보를 얻을 수 있도록 제작하였습니다.

```

### ✔️ 어플리케이션 UI

<h2>시작<h2>
<img width=10% src="/assets/splash.png">

<h2>홈페이지<h2>
<img width=10% src="https://github.com/JeongmoRyu/pyunsik_cvs/assets/122513909/b21847dd-f228-4c8f-a812-3c7aeb0821dc">

```
- carousel을 통한 편의점별 행사 데이터를 직접 연결토록 하였습니다.
- 발전적인 가능성으로 homepage 입장시 크롤링을 통해 실제 서버에 올라와있는 행사 정보 중 할인행사를 제공할 수 있겠다라고 판단하였습니다.
```

<h2>검색 페이지<h2>
<img width=10% src="https://github.com/JeongmoRyu/pyunsik_cvs/assets/122513909/2d5a70fb-bf22-4947-88b3-aba664d06a63">
    
```
- 전체 리스트의 데이터를 페이지네이션하여 데이터를 조금 더 빠르게 가져올 수 있도록 하여 사용자들이 답답함을 느끼지 않도록 구현
- 전체 상품 데이터를 들고오는 것도 로딩시간이 더 걸리므로 개인의 검색 정보에 대한 정보를 기기에 저장할 수 있도록 하여 편의성을 증진시켰습니다.
```

<h2>상품목록 페이지<h2>
<img width=10% src="https://github.com/JeongmoRyu/pyunsik_cvs/assets/122513909/2e5dd268-18e8-4870-849e-9ab24608445a">
    
```
- 전체 리스트의 데이터를 페이지네이션하여 데이터를 조금 더 빠르게 가져올 수 있도록 하여 사용자들이 답답함을 느끼지 않도록 구현
```

<h2>상세보기 페이지<h2>
<img width=10% src="https://github.com/JeongmoRyu/pyunsik_cvs/assets/122513909/05889f16-0938-4e4b-8a8d-0e16b27a6ad4">
    
```
- Cart에 담긴 혹은 삼품의 정보에 따른 기준영양정보와 비교 가능한 Chart와 수치화된 % 값을 통해 균형잡힌 영양정보를 얻을 수 있게 도왔습니다.
- 추후 발전 가능성을 가지고 기준 영양정보가 아닌 사용자들의 데이터를 바탕으로 영양소 추천과 음식 추천까지 가능하다고 판단되었습니다.
```

<h2>상품조합 페이지<h2>
<img width=10% src="https://github.com/JeongmoRyu/pyunsik_cvs/assets/122513909/84e5be80-bc31-436c-a9e0-5602cc44465e">
    
```
- Cart에 담긴 혹은 삼품의 정보에 따른 기준영양정보와 비교 가능한 Chart와 수치화된 % 값을 통해 균형잡힌 영양정보를 얻을 수 있게 도왔습니다.
- 추후 발전 가능성을 가지고 기준 영양정보가 아닌 사용자들의 데이터를 바탕으로 영양소 추천과 음식 추천까지 가능하다고 판단되었습니다.
```

<h2>로그인 페이지<h2>
<img width=10% src="https://github.com/JeongmoRyu/pyunsik_cvs/assets/122513909/4a62cb4a-2f76-4ac4-9855-8cc7a4240458">
    
```
- FCM Token을 통한 Alarm을 구현하였기에 기기별 FCM Token을 가져올 수 있도록 로그인하며 정보를 표시하도록 하였습니다.
```

<h2>스크랩 페이지<h2>
<img width=10% src="https://github.com/JeongmoRyu/pyunsik_cvs/assets/122513909/da48f353-fac3-4d49-9a34-d73bc3ddb7c2">

