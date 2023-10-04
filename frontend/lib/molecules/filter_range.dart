import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/filter.dart';

class FilterRange extends StatefulWidget {
  final String tag;
  const FilterRange({super.key,
    required this.tag,
  });

  @override
  State<FilterRange> createState() => _FilterRangeState();
}

class _FilterRangeState extends State<FilterRange> {
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var filter = context.watch<Filter>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(widget.tag,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                RangeTextField(textController1),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('~'),
                ),
                RangeTextField(textController2),
                TextButton(
                    onPressed: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                      int min = int.parse(textController1.text);
                      int max = int.parse(textController2.text);
                      if (min > max) {
                        print('error: min larger than max');
                        textController1.clear();
                        textController2.clear();
                        return;
                      }
                      filter.changeRange(widget.tag, min, max);
                      // productList.getList();
                    },
                    child: Text('적용')
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget RangeTextField(var controller) {
    return Flexible(

      child: Container(
        constraints: BoxConstraints(maxWidth: 70),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
          style: TextStyle(
            fontSize: 13,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,                      // Added this
            contentPadding: EdgeInsets.all(8),  // Added this
          ),
        ),
      ),
    );
  }
}
