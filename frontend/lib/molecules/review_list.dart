import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../util/constants.dart';

class PriceSum extends StatelessWidget {
  const PriceSum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    int totalPrice = cart.getTotalPrice();
    int totalDiscount = 0;
    int finalPrice = 0;
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

