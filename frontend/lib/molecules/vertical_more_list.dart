import 'package:flutter/material.dart';
import 'package:frontend/atom/text_title.dart';

import '../atom/product_card.dart';

class VerticalMoreList extends StatelessWidget {
  final String title;

  const VerticalMoreList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextTitle(title: title),
        SizedBox(height: 20),
        Container(
          height: 550,
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              for (int i = 0; i < 4; i++)
                ImageWidget(index: i)
            ],
          ),
        )
      ],
    );
  }
}
