import 'package:flutter/material.dart';
import 'package:frontend/atom/button/category_button.dart';

import '../util/constants.dart';


class CategoryList extends StatelessWidget {
  const CategoryList({Key? key});

  @override
  Widget build(BuildContext context) {
    const tag = '편의점';
    return Container(
        height: 80,
        child: ListView(
          itemExtent: 70.0,
          padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
          scrollDirection: Axis.horizontal,
          children: const <Widget>[
            CategoryButton(
              imageUrl: 'assets/images/gs_logo.png',
              tag: tag,
              name: 'GS25',
              showName: false,
            ),
            CategoryButton(
              imageUrl: 'assets/images/cu_logo.png',
              tag: tag,
              name: 'CU',
              showName: false,
            ),
            CategoryButton(
              imageUrl: 'assets/images/711_logo.jpeg',
              tag: tag,
              name: '7-ELEVEN',
              showName: false,
            ),
            CategoryButton(
              imageUrl: 'assets/images/emart24_logo.png',
              tag: tag,
              name: 'emart24',
              showName: false,
            ),
            CategoryButton(
              imageUrl: 'assets/images/11.png',
              tag: '할인행사',
              name: '1+1',
              showName: false,
            ),
            CategoryButton(
              imageUrl: 'assets/images/21.png',
              tag: '할인행사',
              name: '2+1',
              showName: false,
            ),
          ]
        ),
    );
  }
}
