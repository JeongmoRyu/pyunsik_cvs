import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column( //조합이 빈 경우 페이지
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Text(
            '조합이 비어있습니다',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FilledButton(
              onPressed: (){
                context.go('/list/filtered');
              },
              child: Text(
                  '상품 담으러 가기' // 목록 페이지로 이동
              ),
            ),
          )
        ],
      ),
    );
  }
}
