import 'package:flutter/material.dart';
import 'package:frontend/atom/button/category_button.dart';

import '../util/constants.dart';


class CategoryGenreList extends StatelessWidget {
  const CategoryGenreList({Key? key});

  @override
  Widget build(BuildContext context) {
    const tag = '카테고리';
    return Container(
      height: 90,
      child: ListView(
          itemExtent: 80.0,
          padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
          scrollDirection: Axis.horizontal,
          children: const <Widget>[
            CategoryButton(
              imageUrl: 'assets/images/fastfood.jpg',
              tag: tag,
              name: '간편식사',
              showName: true,
            ),
            CategoryButton(
              imageUrl: 'assets/images/instantfood.jpg',
              tag: tag,
              name: '즉석요리',
              showName: true,
            ),
            CategoryButton(
              imageUrl: 'assets/images/snack.jpg',
              tag: tag,
              name: '과자',
              showName: true,

            ),
            CategoryButton(
              imageUrl: 'assets/images/icecream.jpg',
              tag: tag,
              name: '아이스크림',
              showName: true,
            ),
            CategoryButton(
              imageUrl: 'assets/images/food.jpg',
              tag: tag,
              name: '식품',
              showName: true,
            ),
            CategoryButton(
              imageUrl: 'assets/images/beverage.jpg',
              tag: tag,
              name: '음료',
              showName: true,
            ),
          ]
      ),
    );
  }
}
