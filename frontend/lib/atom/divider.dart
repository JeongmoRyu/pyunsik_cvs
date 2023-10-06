import 'package:flutter/material.dart';

class LineDivider extends StatelessWidget {
  const LineDivider({Key? key});


  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.only(left: 15),
          child: Divider(
            height: 10.0,
            color: Colors.grey[850],
            thickness: 1.0,
            endIndent: 20.0,
          ),
        );
  }
}
