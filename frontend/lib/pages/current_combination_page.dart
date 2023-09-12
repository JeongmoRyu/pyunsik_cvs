import 'package:flutter/material.dart';
import 'package:frontend/atom/button/adjust_count_button.dart';
import 'package:frontend/atom/product_card_horizontal.dart';
import 'package:frontend/molecules/combination_list.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/molecules/price_sum.dart';
import '../molecules/top_bar_main.dart';
import '../product.dart';
import '../util/constants.dart';

class CurrentCombinationPage extends StatefulWidget {
  const CurrentCombinationPage({Key? key});

  @override
  State<CurrentCombinationPage> createState() => _CurrentCombinationPageState();
}

class _CurrentCombinationPageState extends State<CurrentCombinationPage> {
  static const int numberOfCombinationProducts = 3; //나중에는 appstate에서 가져와야 함

  bool isCheckedAll = true;
  List<bool> isChecked = List.generate(
      numberOfCombinationProducts,
          (index) => true
  );

  void toggleCheckbox(int index, bool value) {
    setState(() {
      isChecked[index] = value;
      if (!value) { // 개별 체크가 취소 되면 모두 체크 해제
        isCheckedAll = value;
      }
      for (int i = 0; i < isChecked.length; i++) { //모든 개별 체크가 되있으면 모두체크 확인
        if (!isChecked[i]) {
          return;
        }
      }
      isCheckedAll = value;
    });
  }

  void toggleAllCheckbox(bool value) {
    setState(() {
      isCheckedAll = value;
      for (int i = 0; i < isChecked.length; i++) {
        isChecked[i] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> testList = [
      new Product(1, 'test product short', '', 1800),
      new Product(2, 'test product middle middle', '', 39900),
      new Product(3, 'test product long long long long long long long', '', 1498000),
    ];
    List<Product> testList2 = [
      new Product(1, 'test product short', '', 1800),
      new Product(2, 'test product middle middle', '', 39900),
      new Product(3, 'test product long long long long long long long', '', 1498000),
      new Product(1, 'test product short', '', 1800),
      new Product(1, 'test product short', '', 1800),
      new Product(1, 'test product short', '', 1800),
    ];
    return Scaffold(
      appBar: TopBarMain(appBar: AppBar(),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalPadding,
                vertical: Constants.verticalPadding
            ),
            child: Row( //리펙터링 필요
              children: [
                Checkbox(
                    value: isCheckedAll,
                    onChanged: (bool? value) {
                      toggleAllCheckbox(value!);
                    }
                ),
                const Text(
                  '모두선택'
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                      '선택삭제'
                  ),
                ),
              ],
            ),
          ),
          CombinationList(
            productList: testList,
            isChecked: isChecked,
            toggleCheckbox: toggleCheckbox,
          ),
          PriceSum(productList: testList, isChecked: isChecked),
          HorizontalList(
              title: '다른 고객이 함께 구매한 상품',
              productList: testList2
          )
        ],
      ),
    );
  }
}



