import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/molecules/vertical_list.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/molecules/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // 이미지 리스트
  static const List<String> imageList = [
    'assets/images/cvs.jpg',
    'assets/images/cvs.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child : Center(

          child: Column(
            children: [
              SizedBox(height: 20), // 간격 추가
              // 광고 관련 carousel
              CarouselSlider(
                options: CarouselOptions(
                  height: 200, // 슬라이더 높이 조절
                  autoPlay: true, // 자동 슬라이드
                  enlargeCenterPage: true, // 현재 페이지 확대
                  viewportFraction: 1.0, // 현재 화면에 표시될 페이지의 비율을 1로 설정
                  aspectRatio: 16 / 9, // 이미지 비율
                  autoPlayInterval: Duration(seconds: 7), // 자동 슬라이드 간격
                ),
                items: imageList.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0), // 여백 설정
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset(item, fit: BoxFit.fill),
                      );
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 40), // 간격 추가



              // 카테고리 관련 carousel
              CarouselSlider(
                options: CarouselOptions(
                  height: 70,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  viewportFraction: 0.2,
                  aspectRatio: 1 / 1,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                ),
                items: [
                  ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 배경색을 흰색으로 설정
                      minimumSize: MaterialStateProperty.all<Size>(Size(90, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          // 테두리 색상을 지정하고 테두리 두께를 조절합니다.
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(4.0), // 그림자 추가
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/supermarket.png',
                          width: 45,
                          height: 45,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '홈',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/prac2');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 배경색을 흰색으로 설정
                      minimumSize: MaterialStateProperty.all<Size>(Size(90, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          // 테두리 색상을 지정하고 테두리 두께를 조절합니다.
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(4.0), // 그림자 추가
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/supermarket.png',
                          width: 45,
                          height: 45,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '리스트',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/scrapbook');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 배경색을 흰색으로 설정
                      minimumSize: MaterialStateProperty.all<Size>(Size(90, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          // 테두리 색상을 지정하고 테두리 두께를 조절합니다.
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(4.0), // 그림자 추가
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/supermarket.png',
                          width: 45,
                          height: 45,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '스크랩북',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),                ElevatedButton(
                    onPressed: () {
                      context.go('/rank');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 배경색을 흰색으로 설정
                      minimumSize: MaterialStateProperty.all<Size>(Size(90, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          // 테두리 색상을 지정하고 테두리 두께를 조절합니다.
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(4.0), // 그림자 추가
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/supermarket.png',
                          width: 45,
                          height: 45,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '랭크',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 배경색을 흰색으로 설정
                      minimumSize: MaterialStateProperty.all<Size>(Size(90, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          // 테두리 색상을 지정하고 테두리 두께를 조절합니다.
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(4.0), // 그림자 추가
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/supermarket.png',
                          width: 45,
                          height: 45,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '로그인',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/scrapbook');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 배경색을 흰색으로 설정
                      minimumSize: MaterialStateProperty.all<Size>(Size(90, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          // 테두리 색상을 지정하고 테두리 두께를 조절합니다.
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(4.0), // 그림자 추가
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/supermarket.png',
                          width: 45,
                          height: 45,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '스크랩북',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 배경색을 흰색으로 설정
                      minimumSize: MaterialStateProperty.all<Size>(Size(90, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          // 테두리 색상을 지정하고 테두리 두께를 조절합니다.
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(4.0), // 그림자 추가
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/supermarket.png',
                          width: 45,
                          height: 45,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '홈',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/prac2');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 배경색을 흰색으로 설정
                      minimumSize: MaterialStateProperty.all<Size>(Size(90, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          // 테두리 색상을 지정하고 테두리 두께를 조절합니다.
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(4.0), // 그림자 추가
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/supermarket.png',
                          width: 45,
                          height: 45,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '리스트',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/scrapbook');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 배경색을 흰색으로 설정
                      minimumSize: MaterialStateProperty.all<Size>(Size(90, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          // 테두리 색상을 지정하고 테두리 두께를 조절합니다.
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(4.0), // 그림자 추가
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/supermarket.png',
                          width: 45,
                          height: 45,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '스크랩북',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              // Container(
              //   child: ScrollEffect(),
              // ),
              SizedBox(height: 40),
              Container(
                width: 400,
                child : Rank(),
              ),
              // 간격 추가

              // ScrollEffect(),
            ],
          ),
        ),
      ),
    );
  }
}
