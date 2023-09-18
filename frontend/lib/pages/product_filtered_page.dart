import 'package:flutter/material.dart';
import 'package:frontend/molecules/category_list_genre.dart';
import 'package:frontend/molecules/filter_choice.dart';
import 'package:frontend/molecules/filter_list.dart';
import 'package:frontend/molecules/filter_range.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:frontend/molecules/vertical_list.dart';
import 'package:frontend/molecules/appbar.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:provider/provider.dart';

import '../models/filter.dart';
import '../models/product.dart';

class ProductFilteredPage extends StatelessWidget {
  List<Product> testList = [
    new Product(1, 'test product short', '', 1800),
    new Product(2, 'test product middle middle', '', 39900),
    new Product(3, 'test product long long long long long long long', '', 1498000),
    new Product(4, 'test product short', '', 1800),
    new Product(5, 'test product short', '', 1800),
    new Product(6, 'test product short', '', 1800),
    new Product(7, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),
    new Product(8, 'test product short', '', 1800),

  ];
  @override
  Widget build(BuildContext context) {
    var filter = context.watch<Filter>();
    return WillPopScope(
      onWillPop: () async {
          filter.resetFilter();
          return true;
        },
      child: Scaffold(
          appBar: TopBarSub(appBar: AppBar(),),// AppBar에 표시할 제목
          body: ListView(
              children: [
                CustomBox(),
                FilterList(),
                CustomBox(),
                VerticalList(productList: testList)
              ]
          ),
        ),
    );
  }
}
