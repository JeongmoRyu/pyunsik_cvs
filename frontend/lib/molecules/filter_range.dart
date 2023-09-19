import 'package:flutter/material.dart';

import '../util/constants.dart';

class FilterRange extends StatelessWidget {
  final String tag;
  const FilterRange({super.key,
    required this.tag,
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
          child: Row(

            children: [
              RangeTextField(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('~'),
              ),
              RangeTextField(),
              TextButton(
                  onPressed: (){},
                  child: Text('적용')
              )
            ],
          ),
        ),
      ],
    );
  }
}

class RangeTextField extends StatelessWidget {
  const RangeTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,                      // Added this
          contentPadding: EdgeInsets.all(8),  // Added this
        ),
      ),
    );
  }
}
