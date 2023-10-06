import 'package:flutter/material.dart';

import '../atom/promotion_badge.dart';
import '../models/product_simple.dart';

class PromotionBadgeList extends StatelessWidget {
  final ProductSimple product;
  final bool isLarge;
  const PromotionBadgeList({super.key, required this.product, required this.isLarge});

  @override
  Widget build(BuildContext context) {
    double padding = isLarge ? 16 : 8;
    double verticalPadding = isLarge ? 4 : 2;

    if (product.promotionCode == null) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: [
          for (int i = 0; i < product.promotionCode!.length; i++)
            if (product.promotionCode![i] != 0)
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
                child: PromotionBadge(
                  convenienceCode: product.convenienceCode![i],
                  promotionCode: product.promotionCode![i],
                  isLarge: isLarge,
                ),
              )
        ],
      ),
    );
  }
}
