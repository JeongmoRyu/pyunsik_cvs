import 'package:flutter/material.dart';
import 'package:frontend/atom/button/category_button.dart';
import 'package:go_router/go_router.dart';


class CategoryGenreList extends StatelessWidget {
  const CategoryGenreList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView(
          itemExtent: 80.0,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            CategoryButton(
                onPressed: () {
                  context.go('/');
                },
                imageUrl: 'assets/images/burger.png',
                name: '간편식사'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/');
                },
                imageUrl: 'assets/images/noodles.png',
                name: '즉석요리'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/');
                },
                imageUrl: 'assets/images/cookies.png',
                name: '과자'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/');
                },
                imageUrl: 'assets/images/popsicle.png',
                name: '아이스크림'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/');
                },
                imageUrl: 'assets/images/groceries.png',
                name: '식품'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/');
                },
                imageUrl: 'assets/images/drink.png',
                name: '음료'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/');
                },
                imageUrl: 'assets/images/box.png',
                name: '생활용품'
            ),
          ]
      ),
    );
  }
}
