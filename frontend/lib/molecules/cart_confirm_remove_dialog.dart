import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/product_detail.dart';

class CartConfirmRemoveDialog extends StatelessWidget {
  final ProductDetail productDetail;

  const CartConfirmRemoveDialog({
    super.key,
    required this.productDetail,
  });

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return AlertDialog(
      content: const Text('이 상품을 삭제하겠습니까?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            cart.remove(productDetail);
            Navigator.pop(context);
          },
          child: const Text('삭제'),
        ),
      ],
    );
  }
}
