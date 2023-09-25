import 'package:flutter/material.dart';
import 'package:frontend/util/constants.dart';

class PromotionBadge extends StatelessWidget {
  static const Map<int, String> convenienceMap = {
    1 : 'GS25',
    2 : 'CU',
    3 : '7-ELEVEN',
    4 : 'emart24',
  };
  static const Map<int, Color> colorMap = {
    1 : Constants.colorGs25,
    2 : Constants.colorCu,
    3 : Constants.color711,
    4 : Constants.colorEmart24,
  };
  static const Map<int, String> promotionMap = {
    0 : '',
    1 : '1+1',
    2 : '2+1',
  };

  final int convenienceCode;
  final int promotionCode;
  final bool isLarge;

  const PromotionBadge({
    super.key,
    required this.convenienceCode,
    required this.promotionCode,
    required this.isLarge
  });

  @override
  Widget build(BuildContext context) {
    TextStyle smallStyle = TextStyle(
      color: Colors.white,
    );
    if (isLarge) {
      return Container(
        child: Row(
          children: [
            Text(convenienceMap[convenienceCode]!,
                style: TextStyle(
                  fontSize: 20,
                  backgroundColor: colorMap[convenienceCode]!,
                )
            ),
            SizedBox(width: 5,),
            Text(promotionMap[promotionCode]!),
          ],
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: colorMap[convenienceCode]!,
        borderRadius: BorderRadius.all(Radius.circular(3))
      ),
      child: Row(
        children: [
          Flexible(
            child: Text(convenienceMap[convenienceCode]!,
              style: smallStyle
            ),
          ),
          Flexible(
            child: Text(promotionMap[promotionCode]!,
              style: smallStyle
            ),
          ),
        ],
      ),
    );
  }
}
