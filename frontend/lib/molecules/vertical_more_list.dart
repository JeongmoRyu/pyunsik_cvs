import 'package:flutter/material.dart';
import 'package:frontend/atom/text_title.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/util/constants.dart';
import 'package:go_router/go_router.dart';

import '../atom/product_card.dart';
import '../models/product_simple.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/network.dart';
import 'dart:math';

class VerticalMoreList extends StatefulWidget {
  final String title;

  const VerticalMoreList({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _VerticalMoreListState createState() => _VerticalMoreListState();
}

class _VerticalMoreListState extends State<VerticalMoreList> {
  late Future<List<ProductSimple>> productList;

  @override
  void initState() {
    super.initState();
    productList = fetchData();
  }

  Future<List<ProductSimple>> fetchData() async {
    final String apiUrl = "${Network.apiUrl}" + "product/?promotionCodes=1&promotionCodes=2";

    final response = await http.get(Uri.parse(apiUrl), headers: Network.getHeader(''));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final List<ProductSimple> data = (json.decode(body) as List<dynamic>)
          .map((item) => ProductSimple.fromJson(item))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
        vertical: Constants.verticalPadding,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: TextTitle(title: widget.title)),
              Flexible(
                child: TextButton(
                  onPressed: () {
                    context.go('/list/filtered');
                  },
                  child: Text(
                    '더보기',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          FutureBuilder<List<ProductSimple>>(
            future: productList, // Future 형식의 데이터 전달
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final productList = snapshot.data ?? [];

                final max = 4;

                final random = Random();
                final selectedProducts = List.generate(max, (_) {
                  final index = random.nextInt(productList.length);
                  return productList[index];
                });

                return GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 8 / 11,
                  crossAxisCount: 2,
                  children: selectedProducts.map((product) {
                    return ProductCard(product: product);
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
