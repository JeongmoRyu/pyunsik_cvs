import 'package:flutter/material.dart';
import 'package:frontend/atom/text_title.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/util/constants.dart';
import 'package:go_router/go_router.dart';

import '../atom/product_card.dart';
import '../models/product_simple.dart';

class VerticalMoreList extends StatelessWidget {
  final String title;
  final List<ProductSimple> productList;

  const VerticalMoreList({
    super.key,
    required this.title,
    required this.productList
  });

  @override
  Widget build(BuildContext context) {
    int max = 4;
    if (productList.length < 4) {
      max = productList.length;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: Constants.verticalPadding
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: TextTitle(title: title)),
              Flexible(
                child: TextButton(
                    onPressed: () {
                      context.go('/list/filtered');

                    },
                    child: Text(
                  '더보기',
                  textAlign: TextAlign.right,
                )),
              )
            ],
          ),
          SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 8 / 11,
            crossAxisCount: 2,
            children: [
              for (int i = 0; i < max; i++)
                ProductCard(
                  product: productList[i],
                )
            ],
          )
        ],
      ),
    );
  }
}
