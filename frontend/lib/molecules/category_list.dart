import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/atom/button/gs_category_button.dart';
import 'package:frontend/atom/button/cu_category_button.dart';
import 'package:frontend/atom/button/ministop_category_button.dart';


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

        GsButton(
          onPressed: () {
            context.go('/');
          },
        ),
        CuButton(
          onPressed: () {
            context.go('/listpage');
          },
        ),
        MinistopButton(
          onPressed: () {
            context.go('/scrapbook');
          },
        ),
                ElevatedButton(
          onPressed: () {
            context.go('/firstlist');
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
                'assets/images/seveneleven.png',
                width: 45,
                height: 45,
              ),
              SizedBox(height: 4),
              Text(
                '상품 첫',
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
                'assets/images/cu.png',
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
            context.go('/side_scroll_page');
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
                'assets/images/gs.jpg',
                width: 45,
                height: 45,
              ),
              SizedBox(height: 4),
              Text(
                '사이드',
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
                'assets/images/ministop.png',
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
            context.go('/listpage');
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
                'assets/images/seveneleven.png',
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
                'assets/images/cu.png',
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
