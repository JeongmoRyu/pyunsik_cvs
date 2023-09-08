import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imageUrl;
  final String name;

  const CategoryButton({Key? key,
    required this.onPressed,
    required this.imageUrl,
    required this.name,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double containerWidth = 60;
    const double imageWidth = 45;
    return MaterialButton(
      onPressed: onPressed,
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