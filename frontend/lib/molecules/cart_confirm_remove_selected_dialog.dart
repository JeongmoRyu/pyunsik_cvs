import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class CartConfirmRemoveSelectedDialog extends StatelessWidget {
  const CartConfirmRemoveSelectedDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return AlertDialog(
      content: Text('선택한 ${cart.numberOfSelected}개 상품을 삭제하겠습니까?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            cart.removeSelected();
            Navigator.pop(context);
          },
          child: const Text('삭제'),
        ),
      ],
    );
  }
}
