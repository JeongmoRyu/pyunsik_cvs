import 'package:flutter/material.dart';
import 'package:frontend/atom/text_title.dart';
import 'package:frontend/product.dart';

import '../atom/product_card.dart';

class VerticalMoreList extends StatelessWidget {
  final String title;
  final List<Product> productList;

  const VerticalMoreList({
    super.key,
    required this.title,
    required this.productList
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextTitle(title: title),
        SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 4 / 5,
          crossAxisCount: 2,
          children: [
            for (int i = 0; i < 4; i++)
              ProductCard(
                product: productList[i],
              )
          ],
        )
      ],
    );
  }
}
