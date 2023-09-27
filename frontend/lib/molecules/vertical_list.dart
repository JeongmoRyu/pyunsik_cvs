import 'package:flutter/material.dart';
import 'package:frontend/models/product_simple.dart';
import 'package:frontend/util/product_api.dart';
import 'package:provider/provider.dart';
import '../atom/product_card.dart';
import '../models/filter.dart';
import '../util/constants.dart';

class VerticalList extends StatefulWidget {
  const VerticalList({super.key,});

  @override
  State<VerticalList> createState() => _VerticalListState();
}

class _VerticalListState extends State<VerticalList> {
  static const List<String> sortOptions = <String>['기본', '인기순', '낮은 가격순', '높은 가격순', '리뷰 많은순'];
  final List<bool> _toggleButtonsSelection = [false];
  String dropdownValue = sortOptions.first;

  @override
  Widget build(BuildContext context) {
    var filter = context.watch<Filter>();
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: Constants.verticalPadding
      ),
      child: FutureBuilder(
        future: ProductApi.fetchProductList('', filter.getQueryParams()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('----------data received');
            // print(snapshot.data!);
            List<ProductSimple> productList = snapshot.data!
                .map((data) => ProductSimple.fromJson(data as Map<String, dynamic>))
                .toList();
            print(_toggleButtonsSelection[0]);
            if (_toggleButtonsSelection[0]) {
              productList = productList.where((product) {
                if (product.isFavorite == null) {
                  return false;
                }
                return product.isFavorite!;
              }).toList();
            }

            // productList.add(ProductSimple(productId: 1, price: 10000, filename: '', productName: 'test', badge: '1+1'));
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('전체 ${productList.length}'),
                      Spacer(),
                      ToggleButtons(
                        // ToggleButtons uses a List<bool> to track its selection state.
                        isSelected: _toggleButtonsSelection,
                        // This callback return the index of the child that was pressed.
                        onPressed: (int index) {
                          setState(() {
                            _toggleButtonsSelection[index] =
                            !_toggleButtonsSelection[index];
                          });
                        },
                        // Constraints are used to determine the size of each child widget.
                        constraints: const BoxConstraints(
                          minHeight: 32.0,
                          minWidth: 56.0,
                        ),
                        // ToggleButtons uses a List<Widget> to build its children.
                        children: [
                          Text('즐겨찾기'),
                        ],
                      ),
                      SizedBox(width: 20,),
                      DropdownButton(
                        value: dropdownValue,
                        items: sortOptions.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                      )
                    ],
                  ),
                ),
                if (productList.isEmpty)
                  Container(
                    height: 300,
                    child: const Center(
                      child: Text(
                        '조건에 맞는 상품이 존재하지 않습니다.'
                      ),
                    ),
                  )
                else
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
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}
