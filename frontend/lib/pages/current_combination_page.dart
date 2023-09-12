import 'package:flutter/material.dart';
import 'package:frontend/atom/button/adjust_count_button.dart';
import 'package:frontend/atom/product_card_horizontal.dart';
import '../molecules/top_bar_main.dart';
import '../product.dart';

class CurrentCombinationPage extends StatelessWidget {
  const CurrentCombinationPage({Key? key});

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
          ProductCardHorizontal(product: testList[1]),
        ],
      ),
    );
  }
}



