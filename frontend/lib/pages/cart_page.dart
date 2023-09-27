import 'package:flutter/material.dart';
import 'package:frontend/models/product_simple.dart';
import 'package:frontend/molecules/cart_confirm_remove_selected_dialog.dart';
import 'package:frontend/molecules/combination_list.dart';
import 'package:frontend/molecules/empty_cart.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/molecules/price_sum.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:frontend/util/product_api.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../molecules/top_bar_main.dart';
import '../models/product.dart';
import '../util/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/util/auth_api.dart';
import 'package:frontend/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:frontend/molecules/temp_chart_in_all.dart';
import 'package:frontend/molecules/temp_cart_chart.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  String combinationName = '';
  TextEditingController _keyValueController = TextEditingController();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return                   AlertDialog(
          title: Text('텍스트 입력'),
          content: TextField(
            controller: _keyValueController,
            decoration: InputDecoration(
              labelText: '텍스트를 입력하세요',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  combinationName = _keyValueController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var user = context.watch<User>();


    List<ProductSimple> testList2 = [
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
            // TempChartInAll(),
            TempCartChart(),
            CustomBox(),
            HorizontalList(
                title: '다른 고객이 함께 구매한 상품',
                productList: testList2
            ),
            CustomBox(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FilledButton(
                onPressed: () async {
                  _showMyDialog();

                  if (user.accessToken.isNotEmpty) {
                    // 조합 데이터 생성
                    final List<Map<String, dynamic>> combinationList = [];
                    for (final cartProduct in cart.products) {
                      combinationList.add({
                        'productId': cartProduct.productId,
                        'amount': 1,
                      });
                    }

                    final String apiUrl = 'http://j9a505.p.ssafy.io:8881/api/combination/';

                    final Map<String, dynamic> combinationData = {
                      'combinationName': combinationName,
                      'products': combinationList,
                    };

                    try {
                      final response = await http.post(
                        Uri.parse(apiUrl),
                        body: jsonEncode(combinationData),
                        headers: ProductApi.getHeaderWithToken('eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmZDcyYmZjMC1lZjk3LTQ5MWItYmFlZi1mZWI4NGQ1ZjczZDEiLCJyb2xlcyI6WyJST0xFX0NPTlNVTUVSIl0sImlhdCI6MTY5NTI4NDQ3NCwiZXhwIjoxNjk3ODc2NDc0fQ.oLJqbdk5RplL8TQXK0jU4TwsWADWIjxCoup-Gxh5R-I'),
                      );

                      if (response.statusCode == 200) {

                        print('조합 저장 완료');
                        context.go('/scrapbook');
                      } else {
                        // HTTP 요청이 실패했을 때의 로직
                        print('HTTP POST 요청 실패: ${response.statusCode}');
                        // 여기에서 에러 메시지를 처리하거나 사용자에게 표시할 수 있습니다.
                      }
                    } catch (error) {
                      print('예외 발생: $error');
                    }
                  } else {
                    context.push('/login');
                  }
                },
                child: Text('조합 저장'),
              ),
            )
          ],
        ),
    );
  }
}



