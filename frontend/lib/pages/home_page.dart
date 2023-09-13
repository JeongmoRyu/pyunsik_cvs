import 'package:flutter/material.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/molecules/category_list.dart';
import 'package:frontend/molecules/commercial_carousel.dart';
import 'package:frontend/molecules/vertical_more_list.dart';


import '../util/custom_box.dart';
import '../molecules/horizontal_list.dart';
import '../molecules/top_bar_main.dart';
import '../product.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});


  @override
  Widget build(BuildContext context) {
    List<Product> testList = [
      new Product(1, 'test product short', '', 1800),
      new Product(2, 'test product middle middle', '', 39900),
      new Product(3, 'test product long long long long long long long', '', 1498000),
      new Product(4, 'test product short', '', 1800),
      new Product(5, 'test product short', '', 1800),
      new Product(6, 'test product short', '', 1800),
      new Product(7, 'test product short', '', 1800),
      new Product(8, 'test product short', '', 1800),
    ];
    return Scaffold(
      appBar: TopBarMain(appBar: AppBar(),),
      body: ListView(
        children: [
          // 광고 관련 carousel
          CommercialCarousel(),
          CategoryList(),
          CustomBox(),
          VerticalMoreList(title: '오늘의 추천 상품', productList: testList,),
          CustomBox(),
          Ranking(),
          CustomBox(),
          HorizontalList(title: '오늘의 추천 상품', productList: testList,),
          // 간격 추가
          SizedBox(height: 20),
        ],
      ),
    );
  }
}



