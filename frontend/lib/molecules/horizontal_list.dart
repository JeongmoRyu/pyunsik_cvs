import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card.dart';
import 'package:frontend/util/constants.dart';
import 'package:frontend/util/reommendation_api.dart';
import 'package:provider/provider.dart';

import '../atom/loading.dart';
import '../atom/text_title.dart';
import '../models/cart.dart';
import '../models/product_detail.dart';
import '../models/product_simple.dart';
import '../models/user.dart';

class HorizontalList extends StatelessWidget {
  final String title;
  final String type;
  const HorizontalList({
    super.key,
    required this.title, required this.type,
  });

  Future<dynamic> getList(String token, List<ProductDetail> products) {
    List<int> productIdList = products.map((product) => product.productId).toList();
    if (type == 'user') {
      return RecommendationApi.getRecommendationListUser(token);
    }
    if (type == 'combination') {
      return RecommendationApi.getRecommendationListCombination(productIdList);
    }
    return RecommendationApi.getRecommendationListNutrient(productIdList);
  }
  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    var cart = context.watch<Cart>();
    int max = 10;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.horizontalPadding,
            vertical: Constants.verticalPadding
          ),
          child: TextTitle(title: title),
        ),
        FutureBuilder(
          future: getList(user.accessToken, cart.products),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductSimple> productList = snapshot.data!;
              if (productList.length < 10) {
                max = productList.length;
              }
              if (productList.isEmpty) {
                return Container(
                  height: 200,
                  child: Center(child: Text('조건에 맞는 상품이 존재하지 않습니다'))
                );
              }
              return SizedBox(
                height: 270,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 10);
                  },
                  padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
                  scrollDirection: Axis.horizontal, // 가로 스크롤 설정
                  itemCount: max,
                  itemBuilder: (context, index) {
                    return ProductCard(product: productList[index],);
                  },
                ),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.toString());
              return Text('${snapshot.error}');
            }
            return Loading();
          }
        ),
      ],
    );
  }
}
