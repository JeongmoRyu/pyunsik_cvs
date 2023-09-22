import 'package:flutter/material.dart';
import 'package:frontend/models/product_detail.dart';
import 'package:frontend/models/product_simple.dart';
import 'package:frontend/util/network.dart';
import 'package:provider/provider.dart';
import '../atom/product_card.dart';
import '../models/filter.dart';
import '../util/constants.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({super.key,});

  @override
  Widget build(BuildContext context) {
    var filter = context.watch<Filter>();
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: Constants.verticalPadding
      ),
      child: FutureBuilder(
        future: Network.fetchProductList('', filter.getQueryParams()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<ProductSimple> productList = snapshot.data!
                .map((data) => ProductSimple.fromJson(data as Map<String, dynamic>))
                .toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('전체 ${productList.length}'),
                      Spacer(),
                      Text('인기순')
                    ],
                  ),
                ),

                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 8 / 11,
                  crossAxisCount: 2,
                  children: [
                    for (var product in productList)
                      ProductCard(
                        product: product,
                      )
                  ],
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            print(snapshot.toString());
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }
      ),
    );
  }
}
