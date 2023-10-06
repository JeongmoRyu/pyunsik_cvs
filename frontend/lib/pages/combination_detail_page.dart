import 'package:flutter/material.dart';
import 'package:frontend/atom/loading.dart';
import 'package:frontend/molecules/combination_chart.dart';
import 'package:intl/intl.dart';
import '../util/product_api.dart';

import 'package:frontend/util/custom_box.dart';
import 'package:provider/provider.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/atom/product_card_horizontal_without_button.dart';

import '../models/cart.dart';
import '../models/product_simple.dart';
import '../util/constants.dart';

class CombinationDetailPage extends StatefulWidget {
  final int combinationId;

  const CombinationDetailPage({super.key, required this.combinationId});

  @override
  State<CombinationDetailPage> createState() => _CombinationDetailPageState();
}

class _CombinationDetailPageState extends State<CombinationDetailPage> {
  late Future<Map<String, dynamic>> futureCombinationDetail;

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return Scaffold(
        appBar: TopBarSub(appBar: AppBar()),
        body: FutureBuilder<Map<String, dynamic>>(
            future: ProductApi.getCombinationDetail(widget.combinationId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
              } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
              } else {
              final combinationDetail = snapshot.data!;
              final List<dynamic> combinationItems = combinationDetail['combinationItems'];

              return ListView(
                children: [
                  SizedBox(height: 20,),
                  Center(child: Text('${combinationDetail['combinationName']}', style: TextStyle(
                    fontSize: 25
                  ),)),
                  SizedBox(height: 10,),
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10);
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                      vertical: Constants.verticalPadding,
                    ),
                    itemCount: combinationItems.length,
                    itemBuilder: (context, index) {
                      final productMap = combinationItems[index] as Map<String, dynamic>;
                      final product = ProductSimple(
                        productId: productMap['productId'],
                        productName : productMap['productName'],
                        filename : productMap['filename'],
                        price : productMap['price'],
                      );

                      return ProductCardHorizontalWithoutButton(
                        product: product, // 수정된 부분
                      );
                    },
                  ),
                  CustomBox(),
                  Column(
                    children: [
                      PriceText(
                        content: '총 상품금액',
                        price: combinationDetail['totalPrice'],
                      ),
                    ],
                  ),
                  CustomBox(),
                  CombinationChart(
                      totalKcal: combinationDetail['totalKcal'],
                      totalProtein: combinationDetail['totalProtein'],
                      totalFat: combinationDetail['totalFat'],
                      totalCarb: combinationDetail['totalCarb'],
                      totalSodium: combinationDetail['totalSodium']),
                  CustomBox(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FilledButton(
                      onPressed: () async {
                        for (var i = 0; i < combinationItems.length; i++) {
                          final productMap = combinationItems[i] as Map<String, dynamic>;
                          final productId = productMap['productId'];
                          final productDetail = await ProductApi.getProductDetail('', productId);
                          productDetail.productId = productId;
                          if (productDetail != null) {
                            cart.add(productDetail);
                          }
                        }
                        context.go('/cart');
                      },
                      child: Text('현재 조합에 추가'),
                    ),
                  )
                ],
              );
          }
        },
      )
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
        vertical: Constants.verticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(content),
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