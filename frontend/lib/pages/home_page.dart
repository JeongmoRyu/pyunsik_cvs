import 'package:flutter/material.dart';
import 'package:frontend/molecules/vertical_list.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/molecules/category_list.dart';
import 'package:frontend/molecules/commercial_carousel.dart';
import 'package:frontend/atom/divider.dart';

import '../molecules/top_bar_main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarMain(appBar: AppBar(),),
      body: ListView(
        children: [
          // SizedBox(height: 20),
          // 광고 관련 carousel
          CommercialCarousel(),
          SizedBox(height: 20),
          CategoryList(),
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
            child: VerticalList(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(
              width: 400,
              child: Rank(),
            ),
          ),
          // 간격 추가
          SizedBox(height: 20),
        ],
      ),
    );
  }
}



