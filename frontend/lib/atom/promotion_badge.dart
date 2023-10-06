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
      fontSize: 12,
    );

    TextStyle largeStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
    if (isLarge) {
      return Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            color: colorMap[convenienceCode]!,
          ),
          padding: EdgeInsets.all(2),

          child: RichText(
            text: TextSpan(
                text: '${convenienceMap[convenienceCode]!} ',
                style: largeStyle,
                children: [
                  TextSpan(
                      text: promotionMap[promotionCode]!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                  )
                ]
            ),
          ),
        ),
      );
    }
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          color: colorMap[convenienceCode]!,
        ),
        padding: EdgeInsets.all(2),

        child: RichText(
          text: TextSpan(
            text: '${convenienceMap[convenienceCode]!} ',
            style: smallStyle,
            children: [
              TextSpan(
                text: promotionMap[promotionCode]!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}
