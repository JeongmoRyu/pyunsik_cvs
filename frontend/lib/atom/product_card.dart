import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Increased the height to accommodate the text below
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                    'assets/images/coffee.jpg',
                    fit: BoxFit.cover
                ),
                // Image.network(
                //   // 'https://source.unsplash.com/random?sig=$index',
                //   "https://image.woodongs.com/imgsvr/item/GD_8801007922195_001.jpg",
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
          ),
          SizedBox(height: 10), // Adding spacing between the image and text
          Expanded(
            flex: 1,
            child: Text(
              '남양)프렌치카푸치노200ml',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
