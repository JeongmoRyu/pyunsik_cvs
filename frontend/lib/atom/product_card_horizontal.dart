import 'package:flutter/material.dart';
import 'package:frontend/product.dart';
import 'package:intl/intl.dart';

class ProductCardHorizontal extends StatelessWidget {
  static const String defaultFileName = 'assets/images/wip.jpg';

  const ProductCardHorizontal({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    NumberFormat format = NumberFormat.decimalPattern('en_us');

    return Column(
      children: [
        Container(
          height: 80,
          child: Row(
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
              SizedBox(width: 10,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      overflow: TextOverflow.clip,
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
        ),
      ],
    );
  }
}
