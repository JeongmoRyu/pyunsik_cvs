import 'package:flutter/material.dart';
import 'package:frontend/molecules/filter_choice.dart';
import 'package:frontend/molecules/filter_range.dart';
import 'package:frontend/util/constants.dart';

class FilterList extends StatelessWidget {
  const FilterList({super.key});

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
        vertical: Constants.verticalPadding,
      ),
      child: Column(
        children: [
          FilterChoice(tag: '카테고리', options: ['간편식사', '즉석요리', '과자', '아이스크림', '식품', '음료']),
          FilterChoice(tag: '편의점', options: ['GS25', 'CU', '7-ELEVEN', 'emart24']),
          FilterChoice(tag: '할인행사', options: ['1+1', '2+1']),
          FilterRange(tag: '가격 (원)'),
        ],
      ),
    );
  }
}
