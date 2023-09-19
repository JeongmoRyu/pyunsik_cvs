import 'package:flutter/material.dart';
import 'package:frontend/models/filter.dart';
import 'package:provider/provider.dart';

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
    var filter = context.watch<Filter>();
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
                    child: getText(filter, index),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
  Widget getText(var filter, index) {
    if (filter.doesExists(tag, options[index])) {
      return InkWell(
        onTap: () {
          filter.removeChoice(tag, options[index]);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              options[index],
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            const Icon(
              Icons.close,
              size: 18,
            )
          ],
        ),
      );
    }
    return InkWell(
      onTap: () {
        filter.addChoice(tag, options[index]);
      },
      child: Text(
        options[index],
        style: TextStyle(
          color: Colors.grey
        ),
      ),
    );
  }
}

