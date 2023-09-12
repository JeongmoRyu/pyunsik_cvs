import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card_horizontal.dart';

import '../product.dart';
import '../util/constants.dart';

//모바일 저장소에 현재 조합 추가 및 제거 기능 ChangeNotifierProvider 사용
  //combination list 에서 조합을 받아와 체크 상태 저장
class CombinationList extends StatelessWidget {
  final List<Product> productList;
  final List<bool> isChecked;
  final Function toggleCheckbox;

  const CombinationList({
    super.key,
    required this.productList,
    required this.isChecked,
    required this.toggleCheckbox
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10);
      },
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return Row( //디자인 수정 필요
          children: [
            Checkbox(
                value: isChecked[index],
                onChanged: (value) {
                  toggleCheckbox(index, value);
                },
            ),
            Expanded(
                child: ProductCardHorizontal(product: productList[index],)
            ),
          ],
        );
      },
    );
  }
}
