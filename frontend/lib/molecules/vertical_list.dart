import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card.dart';

class ScrollEffect extends StatelessWidget {
  const ScrollEffect({Key? key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 이 값을 2로 설정하여 두 줄로 표시합니다.
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ImageWidget(index: index),
        );
      },
    );
  }
}
