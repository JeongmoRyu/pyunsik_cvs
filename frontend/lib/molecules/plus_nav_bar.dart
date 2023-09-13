import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class PlusNavBar extends StatelessWidget {
  const PlusNavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: Colors.grey,
                    size: 30, // 아이콘 크기를 조절합니다.
                  ),
                ),
              ),
              Text(
                '355',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          SizedBox(width: 10,),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // 버튼 클릭 이벤트 처리
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(300, 50), // 버튼의 최소 너비와 높이를 조절
              ),
              child: Text(
                '추가하기',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20,),
        ],
      ),
    );
  }
}
