import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card.dart';

import '../models/product.dart';

class VerticalList extends StatelessWidget {
  final List<Product> productList;
  const VerticalList({Key? key,
    required this.productList
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 8 / 11,
      crossAxisCount: 2,
      children: [
        for (var product in productList)
          ProductCard(
            product: product,
          )
      ],
    );
  }
}
