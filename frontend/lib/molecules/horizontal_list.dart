import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card.dart';
import 'package:frontend/util/constants.dart';

import '../atom/text_title.dart';
import '../models/product_simple.dart';

class HorizontalList extends StatelessWidget {
  final String title;
  final List<ProductSimple> productList;
  const HorizontalList({
    super.key,
    required this.title,
    required this.productList
  });

  @override
  Widget build(BuildContext context) {
    int max = 6;
    if (productList.length < 6) {
      max = productList.length;
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.horizontalPadding,
            vertical: Constants.verticalPadding
          ),
          child: TextTitle(title: title),
        ),
        Container(
          height: 270,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 10);
            },
            padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
            scrollDirection: Axis.horizontal, // 가로 스크롤 설정
            itemCount: max,
            itemBuilder: (context, index) {
              return ProductCard(product: productList[index],);
            },
          ),
        ),
      ],
    );
  }
}
