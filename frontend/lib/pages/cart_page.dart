import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
import '../util/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/models/user.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';


import 'package:frontend/molecules/combination_chart.dart';

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
        return AlertDialog(
          title: Text('조합 저장'),
          content: TextField(
            controller: _keyValueController,
            decoration: InputDecoration(
              labelText: '조합 이름을 입력하세요',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  combinationName = _keyValueController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var user = context.watch<User>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(0);
    });

    return Scaffold(
      appBar: TopBarMain(appBar: AppBar(),),
      body:  DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('\'뒤로\'버튼을 한번 더 누르시면 종료됩니다.'),
        ),
        child: cart.isEmpty ?
          ListView(controller: _scrollController, children:[
            SizedBox(height: 200,),
            EmptyCart()
          ]) :
          ListView(
            controller: _scrollController,
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
              CustomBox(),
              CombinationChart(
                totalKcal: cart.getTotalKcal(),
                totalCarb: cart.getTotalCarb(),
                totalFat: cart.getTotalFat(),
                totalProtein: cart.getTotalProtein(),
                totalSodium: cart.getTotalSodium(),
              ),
              CustomBox(),
              HorizontalList(
                title: '부족한 영양을 채워줄 상품',
                type: 'nutrient',
              ),
              CustomBox(),
              HorizontalList(
                title: '조합 맞춤 추천 상품',
                type: 'combination',
              ),
              CustomBox(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FilledButton(
                  onPressed: () async {
                    if (user.accessToken.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('로그인이 필요한 기능입니다'),
                          duration: Duration(milliseconds: 1500),
                        ),
                      );
                      context.push('/login');
                      return;
                    }
                    user.change();
                    await _showMyDialog();
                    // 조합 데이터 생성
                    await ProductApi.addCombination(cart.products, combinationName, user.accessToken)
                      .then((value) => context.go('/scrapbook'));
                    user.checkChange();
                  },
                  child: Text('조합 저장'),
                ),
              )
            ],
          ),
      ),
    );
  }
}



