import 'package:flutter/material.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/molecules/category_list_cvs.dart';
import 'package:frontend/molecules/commercial_carousel.dart';
import 'package:frontend/molecules/vertical_more_list.dart';


import '../models/product_simple.dart';
import '../util/custom_box.dart';
import '../molecules/horizontal_list.dart';
import '../molecules/top_bar_main.dart';
import '../models/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});


  @override
  Widget build(BuildContext context) {
    List<ProductSimple> testList = [
    ];
    return Scaffold(

      appBar: TopBarMain(appBar: AppBar(),),
      body: ListView(
        children: [
          // 광고 관련 carousel
          CommercialCarousel(),
          CategoryList(),
          CustomBox(),
          VerticalMoreList(title: '오늘의 행사상품',),
          CustomBox(),
          Ranking(),
          CustomBox(),
          HorizontalList(title: '오늘의 추천상품', productList: testList,),
          // 간격 추가
          SizedBox(height: 20),
        ],
      ),
    );
  }
}



