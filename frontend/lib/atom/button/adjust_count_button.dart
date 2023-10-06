import 'package:flutter/material.dart';

class AdjustCountButton extends StatefulWidget {
  const AdjustCountButton({super.key});

  @override
  State<AdjustCountButton> createState() => _AdjustCountButtonState();
}

class _AdjustCountButtonState extends State<AdjustCountButton> {
  int currentCount = 0;
  void addCount() {
    setState(() {currentCount++;});
  }
  void removeCount() {
    setState(() {
      if (currentCount == 0) {
        return;
      }
      currentCount--;
    });
  }
  @override
  Widget build(BuildContext context) {
    const double height = 30;
    const double width = 30;
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: height,
              width: width,
              child: TextButton(
                  onPressed: removeCount,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(Icons.remove, )

              )
          ),

          Text('$currentCount', textAlign: TextAlign.center),
          SizedBox(
              height: height,
              width: width,
              child: TextButton(
                  onPressed: addCount,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(Icons.add)

              )
          ),
        ],
      ),
    );
  }
}
