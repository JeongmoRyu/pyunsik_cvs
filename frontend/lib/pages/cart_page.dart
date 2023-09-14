import 'package:flutter/material.dart';
import 'package:frontend/molecules/cart_confirm_remove_selected_dialog.dart';
import 'package:frontend/molecules/combination_list.dart';
import 'package:frontend/molecules/empty_cart.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/molecules/price_sum.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../molecules/top_bar_main.dart';
import '../models/product.dart';
import '../util/constants.dart';

import 'package:frontend/molecules/temp_chart_in_all.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

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
      body:  cart.isEmpty ?
        EmptyCart() :
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                  vertical: Constants.verticalPadding
              ),
              child: Row( //리펙터링 필요
                children: [
                  Checkbox(
                      value: cart.isSelectedAll,
                      onChanged: (bool? value) {
                        cart.toggleAllCheckbox(value!);
                      }
                  ),
                  const Text(
                    '모두선택'
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      if (cart.numberOfSelected > 0) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              CartConfirmRemoveSelectedDialog(),
                        );
                      }
                    },
                    child: Text(
                        '선택삭제'
                    ),
                  ),
                ],
              ),
            ),
            CombinationList(),
            CustomBox(),
            PriceSum(),
            TempChartInAll(),
            CustomBox(),
            HorizontalList(
                title: '다른 고객이 함께 구매한 상품',
                productList: testList2
            ),
            CustomBox(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FilledButton(
                  onPressed: (){},
                  child: Text(
                    '조합 저장'
                  ),
              ),
            )
          ],
        ),
    );
  }
}



