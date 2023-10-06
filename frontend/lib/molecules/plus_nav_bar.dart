import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/util/constants.dart';
import 'package:frontend/util/product_api.dart';
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
    if (widget.productDetail.isFavorite != null) {
      isBookmarked = widget.productDetail.isFavorite!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var user = context.watch<User>();
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
                        if (user.accessToken.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('로그인이 필요한 기능입니다'),
                              duration: Duration(milliseconds: 1500),
                            ),
                          );
                          return;
                        }
                        isBookmarked = !isBookmarked;
                        if (isBookmarked) {
                          ProductApi.addFavorite(
                              widget.productDetail.productId, user.accessToken
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('스크랩했습니다'),
                              duration: Duration(milliseconds: 1500),
                            ),
                          );
                          itemCount++;
                        } else {
                          ProductApi.removeFavorite(
                              widget.productDetail.productId, user.accessToken
                          );
                          itemCount--;
                        }
                        user.change();
                      });
                    },
                    icon: Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      color: isBookmarked
                          ? Theme.of(context).primaryColor
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
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  context.go('/cart');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
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
