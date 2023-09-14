import 'package:flutter/material.dart';
import 'package:frontend/atom/button/category_button.dart';
import 'package:go_router/go_router.dart';


class CategoryList extends StatelessWidget {
  const CategoryList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        child: ListView(
            itemExtent: 70.0,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            CategoryButton(
                onPressed: () {
                  context.go('/product_list');
                },
                imageUrl: 'assets/images/gs_logo.png',
                name: 'GS'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_list');
                },
                imageUrl: 'assets/images/cu_logo.png',
                name: 'CU'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_list');
                },
                imageUrl: 'assets/images/711_logo2.jpeg',
                name: '세븐일레븐'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_list');
                },
                imageUrl: 'assets/images/ministop_logo.png',
                name: '미니스톱'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_list');
                },
                imageUrl: 'assets/images/emart24_logo.png',
                name: '이마트24'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_list');
                },
                imageUrl: 'assets/images/cu_logo.png',
                name: 'CU'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_list');
                },
                imageUrl: 'assets/images/711_logo2.jpeg',
                name: '세븐일레븐'
            ),
            CategoryButton(
                onPressed: () {
                  context.go('/product_list');
                },
                imageUrl: 'assets/images/ministop_logo.png',
                name: '미니스톱'
            ),
          ]
        ),
    );
  }
}
