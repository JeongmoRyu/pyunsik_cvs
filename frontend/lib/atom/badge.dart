import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  static const Map<int, String> convenienceMap = {
    1 : 'GS25',
    2 : 'CU',
    3 : '7-ELEVEN',
    4 : 'emart24',
  };
  static const Map<int, String> promotionMap = {
    1 : '1+1',
    2 : '2+1',
  };
  final int convenienceCode;
  final int promotionCode;
  const Badge({
    super.key, required this.convenienceCode, required this.promotionCode
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(convenienceMap[convenienceCode]!),
          Text(promotionMap[promotionCode]!),
        ],
      ),
    );
  }
}
