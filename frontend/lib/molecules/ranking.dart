import 'package:flutter/material.dart';
import 'package:frontend/util/constants.dart';

import '../atom/text_title.dart';

class Ranking extends StatelessWidget {
  final List<String> rankList = [
    'product long long long long long long', '상품2', '상품3', '상품4', '상품5',
    '상품6', '상품7', '상품8', '상품9', '상품10'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: Constants.verticalPadding
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitle(title: '인기 상품',),
          SizedBox(height: 10),
          GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: (1 / .15),
            children: rankList.asMap().entries.map((entry) {
                final int index = entry.key + 1;
                final String item = entry.value;
                return Row(
                  children: [
                    SizedBox(
                      width: 22,
                      child: Text(
                        '$index',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold, // index 텍스트 굵게 표시
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    SizedBox(
                      width: 120,
                      child: Text(
                        '$item',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                );
              }).toList(),
          ),
        ],
      ),
    );
  }
}
