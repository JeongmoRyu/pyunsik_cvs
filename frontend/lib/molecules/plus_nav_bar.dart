import 'package:flutter/material.dart';
import 'package:frontend/util/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/cart.dart';
import '../models/product_detail.dart';

class PlusNavBar extends StatefulWidget {
  final int count;
  final ProductDetail productDetail;

  const PlusNavBar({
    Key? key,
    required this.count,
    required this.productDetail,
  });

  @override
  _PlusNavBarState createState() => _PlusNavBarState();
}

class _PlusNavBarState extends State<PlusNavBar> {
  static NumberFormat format = NumberFormat.decimalPattern('en_us');

  int itemCount = 0;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    itemCount = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return Container(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(
          right: Constants.horizontalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        // 아이콘 클릭 시 상태를 변경합니다.
                        isBookmarked = !isBookmarked;
                        if (isBookmarked) {
                          itemCount++;
                        } else {
                          itemCount--;
                        }
                      });
                    },
                    icon: Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      color: isBookmarked
                          ? Colors.blue
                          : Colors.grey,
                      size: 30,
                    ),
                  ),
                  Text(
                    format.format(itemCount),
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  cart.add(widget.productDetail);
                  context.go('/cart');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minimumSize: Size(200, 50),
                ),
                child: Text(
                  '추가하기',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
