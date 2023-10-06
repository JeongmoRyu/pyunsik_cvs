import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/atom/button/alarm_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          goRouter.go('/'); // 홈 페이지로 이동
        },
        child: Image.asset('assets/images/supermarket.png'),
      ),
      actions: [
        AlarmButton(),

        TextButton(
          onPressed: () {
            goRouter.go('/login'); // 로그인 페이지로 이동
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
