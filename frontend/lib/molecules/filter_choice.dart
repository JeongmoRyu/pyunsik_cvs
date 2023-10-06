import 'package:flutter/material.dart';
import 'package:frontend/models/filter.dart';
import 'package:provider/provider.dart';

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
            height: 35,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 10);
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
    var buttonStyle = TextButton.styleFrom(
      minimumSize: Size.zero,
      padding: EdgeInsets.all(8.0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );

    if (filter.doesExists(tag, options[index])) {
      return TextButton(
        onPressed: () {
          filter.removeChoice(tag, options[index]);
        },
        style: buttonStyle,
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
    return TextButton(
      onPressed: () {
        filter.addChoice(tag, options[index]);
      },
      style: buttonStyle,
      child: Text(
        options[index],
        style: TextStyle(
          color: Colors.grey
        ),
      ),
    );
  }
}

