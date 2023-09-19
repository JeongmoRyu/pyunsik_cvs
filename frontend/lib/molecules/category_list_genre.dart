import 'package:flutter/material.dart';
import 'package:frontend/atom/button/category_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/filter.dart';
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
                imageUrl: 'assets/images/burger.png',
                tag: tag,
                name: '간편식사'
            ),
            CategoryButton(
                imageUrl: 'assets/images/noodles.png',
                tag: tag,
                name: '즉석요리'
            ),
            CategoryButton(
                imageUrl: 'assets/images/cookies.png',
                tag: tag,
                name: '과자'
            ),
            CategoryButton(
                imageUrl: 'assets/images/popsicle.png',
                tag: tag,
                name: '아이스크림'
            ),
            CategoryButton(
                imageUrl: 'assets/images/groceries.png',
                tag: tag,
                name: '식품'
            ),
            CategoryButton(
                imageUrl: 'assets/images/drink.png',
                tag: tag,
                name: '음료'
            ),
            CategoryButton(
                imageUrl: 'assets/images/box.png',
                tag: tag,
                name: '생활용품'
            ),
          ]
      ),
    );
  }
}
