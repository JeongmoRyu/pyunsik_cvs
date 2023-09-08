import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/molecules/vertical_list.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/molecules/appbar.dart';
import 'package:frontend/molecules/category_list.dart';
import 'package:frontend/pages/side_scroll_page.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/molecules/commercial_carousel.dart';
import 'package:frontend/atom/divider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          SizedBox(height: 20), // 간격 추가
          // 광고 관련 carousel
          CommercialCarousel(),
          SizedBox(height: 20), // 간격 추가
          CategoryCarousel(),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              '오늘의 추천 상품',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          LineDivider(),
          Container(
            height: 400,
            width: 350,
            child: ScrollEffect(),
          ),
          SizedBox(height: 20),
          Container(
            width: 400,
            child: Rank(),
          ),
          // 간격 추가
          SizedBox(height: 20),
        ],
      ),
    );
  }
}



