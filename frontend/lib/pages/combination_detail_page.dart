import 'package:flutter/material.dart';
import 'package:frontend/molecules/cart_confirm_remove_selected_dialog.dart';
import 'package:frontend/molecules/combination_list.dart';
import 'package:frontend/molecules/empty_cart.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../molecules/top_bar_sub.dart';
import '../models/product.dart';
import '../util/constants.dart';
import 'package:intl/intl.dart';
import 'package:frontend/atom/product_card_horizontal_without_button.dart';
import 'package:go_router/go_router.dart';

import 'package:frontend/molecules/temp_chart_in_all.dart';

class CombinationDetailPage extends StatefulWidget {
  const CombinationDetailPage({Key? key});

  @override
  State<CombinationDetailPage> createState() => _CombinationDetailPageState();
}

class _CombinationDetailPageState extends State<CombinationDetailPage> {

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    Map<String, dynamic> CombinationDetail = {

      'combinationName': '아이스치즈불닭볶음면',
      'totalPrice' : 5100,
      'totalKcal' : 550,
      'totalCarb':  80.7,
      'totalProtein' : 9,
      'totalFat' : 15.4,
      'totalSodium' : 1090,
      'CombinationItems' : [
        {
          'productId' : 729,
          'productName' : '불닭볶음면',
          'price' : 1800,
          'filename' : 'https://tqklhszfkvzk6518638.cdn.ntruss.com/product/8801073110502.jpg',
          'kcal' : 425,
          'carb':  63,
          'protein' : 9,
          'fat' : 15,
          'sodium' : 950.0,
          'amount' : 1
        },
        {
          'productId' : 1,
          'productName' : '폴라포포도',
          'price' : 1800,
          'filename' : 'https://image.woodongs.com/imgsvr/item/GD_8809713220048_004.jpg',
          'kcal' : 70,
          'carb':  17,
          'protein' : 0,
          'fat' : 0.4,
          'sodium' : 35,
          'amount' : 1
        },
        {
          'productId' : 32,
          'productName' : '인포켓치즈',
          'price' : 1500,
          'filename' : 'https://image.woodongs.com/imgsvr/item/GD_8801155834708.jpg',
          'kcal' : 55,
          'carb':  0.7,
          'protein' : 0,
          'fat' : 0,
          'sodium' : 105,
          'amount' : 1
        },
      ]
    };

    List<Product> combinationItems = (CombinationDetail['CombinationItems'] as List)
        .map((item) => Product(
      item['productId'],
      item['productName'],
      item['filename'],
      item['price'],
    ))
        .toList();


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
      appBar: TopBarSub(appBar: AppBar(),),
      body: ListView(
        children: [
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalPadding,
                vertical: Constants.verticalPadding
            ),
            itemCount: CombinationDetail['CombinationItems'].length,
            itemBuilder: (context, index) {
              final productMap = CombinationDetail['CombinationItems'][index] as Map<String, dynamic>;
              final product = Product(
                productMap['productId'],
                productMap['productName'],
                productMap['filename'],
                productMap['price'],
              );

              return ProductCardHorizontalWithoutButton(
                  product: product,
                );
            },
          ),

          CustomBox(),

          Column(
            children: [
              PriceText(content: '총 상품금액', price: CombinationDetail['totalPrice']),
            ],
          ),

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
              onPressed: () {
                for (var i = 0; i < CombinationDetail['CombinationItems'].length; i++) {
                  final productMap =
                  CombinationDetail['CombinationItems'][i] as Map<String, dynamic>;
                  final product = Product(
                    productMap['productId'],
                    productMap['productName'],
                    productMap['filename'],
                    productMap['price'],
                  );
                  cart.add(product);
                }
                context.go('/cart_page');
              },
              child: Text('Cart에 추가'),
            ),
          )
        ],
      ),
    );
  }
}

class PriceText extends StatelessWidget {
  static NumberFormat format = NumberFormat.decimalPattern('en_us');

  final String content;
  final int price;
  const PriceText({
    super.key,
    required this.content,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: Constants.verticalPadding
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              content
          ),
          Text(
            format.format(price) + '원',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
