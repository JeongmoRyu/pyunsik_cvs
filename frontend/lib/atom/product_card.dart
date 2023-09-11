import 'package:flutter/material.dart';
import 'package:frontend/product.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  static const String defaultFileName = 'assets/images/wip.jpg';

  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    NumberFormat format = NumberFormat.decimalPattern('en_us');

    return SizedBox(
      height: 50,
      width: 200,
      // child: Container(
      //   color: Colors.pink,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                    defaultFileName, //임시 이미지
                    fit: BoxFit.cover
                ),
              ),
          ),
          Text(
            product.productName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            format.format(product.price),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    // return SizedBox(
    //   height: 200, // Increased the height to accommodate the text below
    //   width: double.infinity,
    //   child: Column(
    //     children: [
    //       Expanded(
    //         flex: 2,
    //         child: Card(
    //           child: AspectRatio(
    //             aspectRatio: 1 / 1,
    //             child: Image.asset(
    //                 'assets/images/coffee.jpg',
    //                 fit: BoxFit.cover
    //             ),
    //             // Image.network(
    //             //   // 'https://source.unsplash.com/random?sig=$index',
    //             //   "https://image.woodongs.com/imgsvr/item/GD_8801007922195_001.jpg",
    //             //   fit: BoxFit.cover,
    //             // ),
    //           ),
    //         ),
    //       ),
    //       SizedBox(height: 10), // Adding spacing between the image and text
    //       Expanded(
    //         flex: 1,
    //         child: Text(
    //           '남양)프렌치카푸치노200ml',
    //           style: TextStyle(
    //             fontSize: 18,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
