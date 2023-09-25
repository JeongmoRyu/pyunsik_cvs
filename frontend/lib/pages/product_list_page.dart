import 'package:flutter/material.dart';
import 'package:frontend/molecules/top_bar_main.dart';
import 'package:frontend/util/constants.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/molecules/category_list_cvs.dart';
import 'package:frontend/molecules/horizontal_list.dart';

import 'package:frontend/molecules/category_list_genre.dart';

import '../models/product.dart';
import '../models/product_simple.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key});


  @override
  Widget build(BuildContext context) {
    List<ProductSimple> testList = [

    ];

    return Scaffold(
      appBar: TopBarMain(appBar: AppBar(),),
      body: ListView(
        children: [
          CategoryList(),
          CategoryGenreList(),
          CustomBox(),
          HorizontalList(title: '오늘의 추천 상품', productList: testList),
          CustomBox(),
          Ranking(),
        ],
      ),
    );
  }
}



