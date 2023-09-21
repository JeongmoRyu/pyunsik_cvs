import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/util/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
// import 'package:frontend/models/productdetail.dart';

import '../models/cart.dart';

class PlusNavBar extends StatefulWidget {
  final int count;
  const PlusNavBar({
    super.key,
    required this.count,
  });

  @override
  _PlusNavBarState createState() => _PlusNavBarState();
}

class _PlusNavBarState extends State<PlusNavBar> {
  static NumberFormat format = NumberFormat.decimalPattern('en_us');

  int itemCount = 355;
  bool isBookmarked = false;

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
                    format.format(widget.count),
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
                  cart.add(new Product(6, '불닭볶음면', '', 1800));
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
