import 'package:flutter/material.dart';
import 'package:frontend/atom/product_image.dart';
import 'package:frontend/atom/promotion_badge.dart';
import 'package:frontend/molecules/promotion_badge_list.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../models/product_simple.dart';

class ProductCard extends StatelessWidget {
  static NumberFormat format = NumberFormat.decimalPattern('en_us');

  final ProductSimple product;

  const ProductCard({Key? key, required this.product}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: InkWell(
        onTap: () {
          context.push('/detail', extra: product.productId);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: ProductImage(filename: product.filename,),
                    ),
                ),
                PromotionBadgeList(
                  product: product,
                  isLarge: false,
                )
              ]
            ),
            Text(
              product.productName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              format.format(product.price),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
