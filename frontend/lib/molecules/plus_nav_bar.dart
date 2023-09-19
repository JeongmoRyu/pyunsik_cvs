import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/cart.dart';

class PlusNavBar extends StatefulWidget {
  const PlusNavBar({Key? key});

  @override
  _PlusNavBarState createState() => _PlusNavBarState();
}

class _PlusNavBarState extends State<PlusNavBar> {
  int itemCount = 355;
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return Container(
      height: 60,
      child: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: IconButton(
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
              ),
              Text(
                '$itemCount',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          SizedBox(width: 10,),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                cart.add(new Product(6, '불닭볶음면', '', 1800));
                context.go('/cart');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(300, 50),
              ),
              child: Text(
                '추가하기',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20,),
        ],
      ),
    );
  }
}
