import 'package:flutter/material.dart';
import 'package:frontend/models/product_simple.dart';
import 'package:frontend/util/product_api.dart';
import 'package:provider/provider.dart';
import '../atom/loading.dart';
import '../atom/product_card.dart';
import '../models/filter.dart';
import '../util/constants.dart';

class VerticalList extends StatefulWidget {
  final int pageNumber;
  final Function reset;

  const VerticalList({super.key,
    required this.pageNumber, required this.reset,});

  @override
  State<VerticalList> createState() => _VerticalListState();
}

class _VerticalListState extends State<VerticalList> {
  static const List<String> sortOptions = <String>['기본', '낮은 가격순', '높은 가격순'];
  final List<bool> _toggleButtonsSelection = [false];
  String dropdownValue = sortOptions.first;
  int prevCount = 0;

  @override
  Widget build(BuildContext context) {
    var filter = context.watch<Filter>();

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: Constants.verticalPadding
      ),
      child: FutureBuilder(
        future: ProductApi.getProductList('', filter.getQueryParams()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('----------data received');
            // print(snapshot.data!);
            List<ProductSimple> productList = snapshot.data!
                .map((data) => ProductSimple.fromJson(data as Map<String, dynamic>))
                .toList();

            if (_toggleButtonsSelection[0]) {
              productList = productList.where((product) {
                if (product.isFavorite == null) {
                  return false;
                }
                return product.isFavorite!;
              }).toList();
            }
            if (dropdownValue == '낮은 가격순') {
              productList.sort((a, b) =>
                a.price.compareTo(b.price)
              );
            }
            if (dropdownValue == '높은 가격순') {
              productList.sort((a, b) =>
                  b.price.compareTo(a.price)
              );
            }
            int productCount = widget.pageNumber * 24;
            if (productCount > productList.length) {
              productCount = productList.length;
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('전체 ${productList.length}'),
                      Spacer(),
                      // ToggleButtons(
                      //   // ToggleButtons uses a List<bool> to track its selection state.
                      //   isSelected: _toggleButtonsSelection,
                      //   // This callback return the index of the child that was pressed.
                      //   onPressed: (int index) {
                      //     setState(() {
                      //       _toggleButtonsSelection[index] =
                      //       !_toggleButtonsSelection[index];
                      //     });
                      //   },
                      //   // Constraints are used to determine the size of each child widget.
                      //   constraints: const BoxConstraints(
                      //     minHeight: 32.0,
                      //     minWidth: 56.0,
                      //   ),
                      //   borderColor: Colors.white,
                      //   borderRadius: BorderRadius.all(Radius.circular(5)),
                      //   // ToggleButtons uses a List<Widget> to build its children.
                      //   children: [
                      //     Text('즐겨찾기'),
                      //   ],
                      // ),
                      SizedBox(width: 20,),
                      DropdownButton(
                        value: dropdownValue,
                        items: sortOptions.map((String items) {
                          return DropdownMenuItem(

                            value: items,
                            child: Text(items, style: TextStyle(
                              fontSize: 14
                            )),
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
                      for (int i = 0; i < productCount; i++)
                        ProductCard(
                          product: productList[i],
                        )

                      // for (var product in productList)
                      //   ProductCard(
                      //     product: product,
                      //   )
                    ],
                  ),


              ],
            );
          }
          if (snapshot.hasError) {
            print(snapshot.toString());
            return Text('${snapshot.error}');
          }
          return Loading();
        }
      ),
    );
  }
}
