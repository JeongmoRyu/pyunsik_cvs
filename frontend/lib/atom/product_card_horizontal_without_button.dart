import 'package:flutter/material.dart';
import 'package:frontend/atom/product_image.dart';
import 'package:intl/intl.dart';

import '../models/product_simple.dart';

class ProductCardHorizontalWithoutButton extends StatelessWidget {
  static NumberFormat format = NumberFormat.decimalPattern('en_us');
  const ProductCardHorizontalWithoutButton({Key? key, required this.product}) : super(key: key);

  final ProductSimple product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: ProductImage(filename: product.filename,)
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Spacer(),
                Text(
                  format.format(product.price) + '원',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}