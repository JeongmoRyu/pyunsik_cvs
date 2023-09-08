import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';




class CommercialCarousel extends StatelessWidget {
  const CommercialCarousel({Key? key});

  static const List<String> imageList = [
    'assets/images/cvs.jpg',
    'assets/images/cvs.jpg',
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
        child : CarouselSlider(
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
        )
    );
  }
}
