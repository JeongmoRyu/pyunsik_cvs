import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child :CarouselSlider(
          options: CarouselOptions(
            height: 70,
            autoPlay: false,
            enlargeCenterPage: false,
            viewportFraction: 0.2,
            aspectRatio: 1 / 1,
            enableInfiniteScroll: false,
            initialPage: 2,

            // finalPage: -2

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
        )
    );
  }
}
