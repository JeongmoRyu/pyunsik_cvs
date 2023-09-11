import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card.dart';

import '../atom/text_title.dart';
import '../product.dart';

class HorizontalList extends StatelessWidget {
  final String title;
  final List<Product> productList;
  const HorizontalList({
    super.key,
    required this.title,
    required this.productList
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        TextTitle(title: '오늘의 추천 상품'),
        SizedBox(height: 10),
        Container(
          height: 270,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 10);
            },
            scrollDirection: Axis.horizontal, // 가로 스크롤 설정
            itemCount: 6,
            itemBuilder: (context, index) {
              return ProductCard(product: productList[index],);
            },
          ),
        ),
      ],
    );
  }
}
