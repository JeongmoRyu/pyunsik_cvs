import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card.dart';

class SideScrollEffect extends StatelessWidget {
  const SideScrollEffect({Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal, // 가로 스크롤 설정
      itemCount: 10,
      itemExtent: 200,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ImageWidget(index: index),
        );
      },
    );
  }
}
