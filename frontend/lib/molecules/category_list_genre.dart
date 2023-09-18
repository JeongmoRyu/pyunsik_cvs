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
    var filter = context.watch<Filter>();
    const tagName = '카테고리';
    return Container(
      height: 90,
      child: ListView(
          itemExtent: 80.0,
          padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            CategoryButton(
                onPressed: () {
                  filter.addChoice(tagName, '간편식사');
                  context.go('/product_filtered');
                },
                imageUrl: 'assets/images/burger.png',
                name: '간편식사'
            ),
            CategoryButton(
                onPressed: () {
                  filter.addChoice(tagName, '즉석요리');
                  context.go('/product_filtered');
                },
                imageUrl: 'assets/images/noodles.png',
                name: '즉석요리'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_filtered');
                },
                imageUrl: 'assets/images/cookies.png',
                name: '과자'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_filtered');
                },
                imageUrl: 'assets/images/popsicle.png',
                name: '아이스크림'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_filtered');
                },
                imageUrl: 'assets/images/groceries.png',
                name: '식품'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_filtered');
                },
                imageUrl: 'assets/images/drink.png',
                name: '음료'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_filtered');
                },
                imageUrl: 'assets/images/box.png',
                name: '생활용품'
            ),
          ]
      ),
    );
  }
}
