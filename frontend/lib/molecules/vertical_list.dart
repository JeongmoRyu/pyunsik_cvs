import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card.dart';
import 'package:frontend/models/product_list.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../util/constants.dart';

class VerticalList extends StatelessWidget {
  final List<Product> productList;
  const VerticalList({Key? key,
    required this.productList
  });

  @override
  Widget build(BuildContext context) {
    var productList = context.watch<ProductList>();
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: Constants.verticalPadding
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('전체 ${productList.numberOfProducts}'),
                Spacer(),
                Text('인기순')
              ],
            ),
          ),

          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 8 / 11,
            crossAxisCount: 2,
            children: [
              for (var product in productList.products)
                ProductCard(
                  product: product,
                )
            ],
          ),
        ],
      ),
    );
  }
}
