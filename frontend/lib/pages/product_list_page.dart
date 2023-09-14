import 'package:flutter/material.dart';
import 'package:frontend/molecules/top_bar_main.dart';
import 'package:frontend/util/constants.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/molecules/category_list_cvs.dart';
import 'package:frontend/molecules/horizontal_list.dart';

import 'package:frontend/molecules/category_list_genre.dart';

import '../models/product.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key});


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
          Padding(
            padding: const EdgeInsets.all(Constants.horizontalPadding),
            child: CategoryList(),
          ),
          Padding(
            padding: const EdgeInsets.all(Constants.horizontalPadding),
            child: CategoryGenreList(),
          ),
          CustomBox(),
          HorizontalList(title: '오늘의 추천 상품', productList: testList),
          CustomBox(),
          Ranking(),
        ],
      ),
    );
  }
}



