import 'package:flutter/material.dart';
import 'package:frontend/molecules/vertical_list.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/molecules/category_list.dart';
import 'package:frontend/molecules/commercial_carousel.dart';
import 'package:frontend/atom/divider.dart';
import 'package:frontend/molecules/vertical_more_list.dart';

import '../molecules/top_bar_main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarMain(appBar: AppBar(),),
      body: ListView(
        children: [
          // 광고 관련 carousel
          CommercialCarousel(),
          SizedBox(height: 10,),
          CategoryList(),
          SizedBox(height: 10,),
          VerticalMoreList(title: '오늘의 추천 상품'),
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



