import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card.dart';
import 'package:frontend/util/constants.dart';

import '../atom/loading.dart';
import '../atom/text_title.dart';
import '../models/product_simple.dart';

class HorizontalList extends StatelessWidget {
  final String title;
  final Future<dynamic> apiFunction;
  const HorizontalList({
    super.key,
    required this.title, required this.apiFunction,
  });

  @override
  Widget build(BuildContext context) {
    int max = 6;
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
          future: apiFunction,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductSimple> productList = snapshot.data!;
              if (productList.length < 6) {
                max = productList.length;
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
