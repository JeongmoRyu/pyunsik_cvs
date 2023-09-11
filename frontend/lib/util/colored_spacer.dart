import 'package:flutter/material.dart';

class ColoredSpacer extends StatelessWidget {
  const ColoredSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      color: Color.fromRGBO(241, 241, 241, 1.0),
    );
  }
}
