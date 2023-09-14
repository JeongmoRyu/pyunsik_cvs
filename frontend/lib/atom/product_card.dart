import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/cart.dart';

class ProductCard extends StatelessWidget {
  static const String defaultFileName = 'assets/images/wip.jpg';
  static NumberFormat format = NumberFormat.decimalPattern('en_us');
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return SizedBox(
      width: 200,
      child: InkWell(
        onTap: () {
          context.go('/product_detail');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                      defaultFileName, //임시 이미지
                      fit: BoxFit.cover
                  ),
                ),
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
