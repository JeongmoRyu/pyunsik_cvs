import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/network.dart';

import 'package:frontend/models/product.dart';
import 'package:frontend/molecules/temp_chart_in_all.dart';
import 'package:frontend/molecules/horizontal_list.dart';
import 'package:frontend/molecules/cart_confirm_remove_selected_dialog.dart';
import 'package:frontend/molecules/combination_list.dart';
import 'package:frontend/molecules/empty_cart.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:provider/provider.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/atom/product_card_horizontal_without_button.dart';

import '../models/cart.dart';
import '../models/product_simple.dart';
import '../util/constants.dart';

class CombinationDetailPage extends StatefulWidget {
  const CombinationDetailPage({Key? key});

  @override
  State<CombinationDetailPage> createState() => _CombinationDetailPageState();
}

class _CombinationDetailPageState extends State<CombinationDetailPage> {
  late Future<Map<String, dynamic>> futureCombinationDetail;

  @override
  void initState() {
    super.initState();
    futureCombinationDetail = fetchCombinationDetail();
  }

  Future<Map<String, dynamic>> fetchCombinationDetail() async {
    final combinationId = 3;
    final token = 'User-token';
    final uri = Uri.parse('${Network.apiUrl}combination/$combinationId');
    final response = await http.get(uri, headers: Network.getHeader(token));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = json.decode(body);
      return data;
    } else {
      throw Exception('Failed to load data. Status Code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return FutureBuilder<Map<String, dynamic>>(
      future: futureCombinationDetail,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final combinationDetail = snapshot.data!;
          final List<dynamic> combinationItems = combinationDetail['combinationItems'];

          return Scaffold(
            appBar: TopBarSub(appBar: AppBar()),
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
                    vertical: Constants.verticalPadding,
                  ),
                  itemCount: combinationItems.length,
                  itemBuilder: (context, index) {
                    final productMap = combinationItems[index] as Map<String, dynamic>;
                    final product = Product(
                      productMap['productId'],
                      productMap['productName'],
                      productMap['filename'],
                      productMap['price'],
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
                TempChartInAll(),
                CustomBox(),
                CustomBox(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FilledButton(
                    onPressed: () async {
                      for (var i = 0; i < combinationItems.length; i++) {
                        final productMap = combinationItems[i] as Map<String, dynamic>;
                        final productId = productMap['productId'];
                        final productDetail = await Network.fetchProductDetail('', productId);
                        if (productDetail != null) {
                          cart.add(productDetail);
                        }
                      }
                      context.go('/cart');
                    },
                    child: Text('Cart에 추가'),
                  ),
                )
              ],
            ),
          );
        }
      },
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