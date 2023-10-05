import 'package:flutter/material.dart';
import 'package:frontend/atom/product_image.dart';

import 'package:frontend/molecules/cart_confirm_remove_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../models/product_detail.dart';


class ProductCardHorizontal extends StatelessWidget {
  // static const String defaultFileName = 'assets/images/wip.jpg';
  static NumberFormat format = NumberFormat.decimalPattern('en_us');
  const ProductCardHorizontal({Key? key, required this.productDetail}) : super(key: key);

  final ProductDetail productDetail;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/detail', extra: productDetail.productId); //prodcuctId 필요
        // 특정 상품 디테일 페이지로 넘어가게 수정 필요
      },
      child: SizedBox(
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: ProductImage(filename: productDetail.filename,)
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
                      fontSize: 17,
                    ),
                  ),
                  Spacer(),
                  Text(
                    format.format(productDetail.price) + '원',
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontSize: 17,
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
      ),
    );
  }
}
