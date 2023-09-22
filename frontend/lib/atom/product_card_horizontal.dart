import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/productdetail.dart';

import 'package:frontend/molecules/cart_confirm_remove_dialog.dart';
import 'package:intl/intl.dart';


class ProductCardHorizontal extends StatelessWidget {
  // static const String defaultFileName = 'assets/images/wip.jpg';
  static NumberFormat format = NumberFormat.decimalPattern('en_us');
  const ProductCardHorizontal({Key? key, required this.productDetail}) : super(key: key);

  final ProductDetail productDetail;

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
              child: Image.network(
                  productDetail.filename,
                  fit: BoxFit.cover
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productDetail.productName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Spacer(),
                Text(
                  format.format(productDetail.price) + '원',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    CartConfirmRemoveDialog(productDetail: productDetail)
            ),
            icon: Icon(Icons.close),
          )
        ],
      ),
    );
  }
}
