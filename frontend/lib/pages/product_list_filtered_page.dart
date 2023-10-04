import 'package:flutter/material.dart';
import 'package:frontend/molecules/filter_list.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:frontend/molecules/vertical_list.dart';
import 'package:frontend/util/custom_box.dart';
import 'package:provider/provider.dart';

import '../models/filter.dart';

class ProductFilteredPage extends StatefulWidget {
  const ProductFilteredPage({super.key});

  @override
  State<ProductFilteredPage> createState() => _ProductFilteredPageState();
}

class _ProductFilteredPageState extends State<ProductFilteredPage> {
  final ScrollController _scrollController = ScrollController();
  var pageNumber = 1; // update in API CALL

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(() {
    //   print('offset = ${_scrollController.offset}');
    // });
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          pageNumber += 1;
        });
        print(pageNumber);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            controller: _scrollController,
            children: [
              CustomBox(),
              FilterList(),
              CustomBox(),
              VerticalList(pageNumber: pageNumber, reset: () {
                setState(() {
                  pageNumber = 1;
                });
              },)
            ]
          ),
        ),
    );
  }
}
