import 'package:flutter/material.dart';
import 'package:frontend/util/constants.dart';
import 'package:go_router/go_router.dart';

import '../atom/text_title.dart';

class Ranking extends StatelessWidget {
  final List<Map<String, String>> rankList = [
    {'keyword': '상품 long long long long long long long long 1'},
    {'keyword': '상품2'},
    {'keyword': '상품3'},
    {'keyword': '상품4'},
    {'keyword': '상품5'},
    {'keyword': '상품6'},
    {'keyword': '상품7'},
    {'keyword': '상품8'},
    {'keyword': '상품9'},
    {'keyword': '상품10'}
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
        vertical: Constants.verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitle(
            title: '실시간 인기 검색어',
          ),
          SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: (1 / .15),
            children: rankList.map((item) {
              final int index = rankList.indexOf(item) + 1;
              final String itemName = item['keyword'] ?? '';
              return Row(
                children: [
                  SizedBox(
                    width: 22,
                    child: Text(
                      '$index',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      context.push('/detail', extra: 1); //prodcuctId 필요
                      // 특정 상품 디테일 페이지로 넘어가게 수정 필요
                    },
                    child: SizedBox(
                      width: 120,
                      child: Text(
                        itemName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
