import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card_horizontal.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../util/constants.dart';

//모바일 저장소에 현재 조합 추가 및 제거 기능 ChangeNotifierProvider 사용
  //combination list 에서 조합을 받아와 체크 상태 저장
class CombinationList extends StatelessWidget {
  const CombinationList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10);
      },
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: Constants.verticalPadding
      ),
      itemCount: cart.numberOfProducts,
      itemBuilder: (context, index) {
        return Row( //디자인 수정 필요
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
                value: cart.isSelected[index],
                onChanged: (value) {
                  cart.toggleCheckbox(index, value!);
                },
            ),
            SizedBox(width: 10,),
            Expanded(
                child: ProductCardHorizontal(productDetail: cart.products[index],)
            ),
          ],
        );
      },
    );
  }
}
