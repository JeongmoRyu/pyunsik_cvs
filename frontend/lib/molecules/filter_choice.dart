import 'package:flutter/material.dart';

import '../util/constants.dart';

class FilterChoice extends StatelessWidget {
  final String tag;
  final List<String> options;
  const FilterChoice({super.key,
    required this.tag,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(tag,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 50,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 20);
              },
              scrollDirection: Axis.horizontal, // 가로 스크롤 설정
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Center(
                    child: Text(options[index], textAlign: TextAlign.center,)
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
