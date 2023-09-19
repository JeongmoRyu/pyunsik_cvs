import 'package:flutter/material.dart';
import 'package:frontend/atom/button/category_button.dart';
import 'package:go_router/go_router.dart';

import '../util/constants.dart';


class CategoryList extends StatelessWidget {
  const CategoryList({Key? key});

  @override
  Widget build(BuildContext context) {
    const tag = '편의점';
    return Container(
        height: 90,
        child: ListView(
          itemExtent: 70.0,
          padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
          scrollDirection: Axis.horizontal,
          children: const <Widget>[
            CategoryButton(
                imageUrl: 'assets/images/gs_logo.png',
                tag: tag,
                name: 'GS25'
            ),
            CategoryButton(
                imageUrl: 'assets/images/cu_logo.png',
                tag: tag,
                name: 'CU'
            ),
            CategoryButton(
                imageUrl: 'assets/images/711_logo2.jpeg',
                tag: tag,
                name: '세븐일레븐'
            ),
            CategoryButton(
                imageUrl: 'assets/images/ministop_logo.png',
                tag: tag,
                name: '미니스톱'
            ),
            CategoryButton(
                imageUrl: 'assets/images/emart24_logo.png',
                tag: tag,
                name: '이마트24'
            ),
            CategoryButton(
                imageUrl: 'assets/images/wip.jpg',
                tag: '할인행사',
                name: '1+1'
            ),
            CategoryButton(
                imageUrl: 'assets/images/wip.jpg',
                tag: '할인행사',
                name: '2+1'
            ),
          ]
        ),
    );
  }
}
