import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../product.dart';
import '../util/constants.dart';

class PriceSum extends StatelessWidget {

  final List<Product> productList;
  final List<bool> isChecked;

  const PriceSum({
    super.key,
    required this.productList,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    int totalDiscount = 0;
    int finalPrice = 0;
    for (int i = 0; i < productList.length; i++) {
      if (isChecked[i]) {
        totalPrice += productList[i].price;
      }
    }
    finalPrice = totalPrice - totalDiscount;
    return Column(

      children: [
        PriceText(content: '총 상품금액', price: totalPrice),
        PriceText(content: '총 할인금액', price: totalDiscount),
        PriceText(content: '최종금액', price: finalPrice),
      ],
    );
  }
}

class PriceText extends StatelessWidget {
  static NumberFormat format = NumberFormat.decimalPattern('en_us');

  final String content;
  final int price;
  const PriceText({
    super.key,
    required this.content,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
        vertical: Constants.verticalPadding
      ),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            content
          ),
          Text(
            format.format(price) + '원',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

