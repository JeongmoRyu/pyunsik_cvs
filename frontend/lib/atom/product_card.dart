import 'package:flutter/material.dart';
import 'package:frontend/product.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  static const String defaultFileName = 'assets/images/wip.jpg';

  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    NumberFormat format = NumberFormat.decimalPattern('en_us');

    return SizedBox(
      width: 200,
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
    );
  }
}
