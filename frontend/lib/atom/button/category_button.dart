import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/filter.dart';

class CategoryButton extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String name;

  const CategoryButton({Key? key,
    required this.imageUrl,
    required this.tag,
    required this.name,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filter = context.watch<Filter>();
    const double containerWidth = 60;
    const double imageWidth = 45;
    return MaterialButton(
      onPressed: () {
        filter.addChoice(tag, name);
        context.go('/list/filtered');
      },
      padding: EdgeInsets.zero,
      minWidth: containerWidth,
      child: Column(
        children: [
          Container(
            height: containerWidth,
            width: containerWidth,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white24,

            ),
            child: Image.asset(
              imageUrl,
              width: imageWidth,
              height: imageWidth,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}