import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlarmButton extends StatelessWidget {
  const AlarmButton({Key? key});

  @override
  Widget build(BuildContext context) {
    final GoRouter goRouter = GoRouter.of(context);

    return PopupMenuButton(
      icon: Icon(
        FontAwesomeIcons.bell,
        color: Colors.black,
      ),
      offset: Offset(0, kToolbarHeight), // 이 옵션을 사용하여 팝업 메뉴의 위치를 조정합니다.
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          _buildPopupMenuItem(
            imageAsset: 'assets/images/gs_logo.png',
            text: 'GS에서 9개 상품이 할인 중입니다.',
            route: '/product_list_page',
            goRouter: goRouter,
            backgroundColor: Colors.white,
          ),
          _buildPopupMenuItem(
            imageAsset: 'assets/images/cu_logo.png',
            text: 'CU에서 10개 상품이 할인 중입니다.',
            route: '/product_list_page',
            goRouter: goRouter,
            backgroundColor: Colors.white,
          ),
          _buildPopupMenuItem(
            imageAsset: 'assets/images/ministop_logo.png',
            text: 'MiniStop에서 7개 상품이 할인 중입니다.',
            route: '/product_list_page',
            goRouter: goRouter,
            backgroundColor: Colors.white,
          ),
          _buildPopupMenuItem(
            imageAsset: 'assets/images/711_logo2.jpeg',
            text: 'SevenEleven에서 5개 상품이 할인 중입니다.',
            route: '/product_list_page',
            goRouter: goRouter,
            backgroundColor: Colors.white,
          ),
        ];
      },
    );
  }

  PopupMenuItem _buildPopupMenuItem({
    required String imageAsset,
    required String text,
    required String route,
    required GoRouter goRouter,
    Color? backgroundColor,
  }) {
    return PopupMenuItem(
      child: Container(
        color: backgroundColor,
        child: ListTile(
          leading: Image.asset(
            imageAsset,
            width: 45,
            height: 45,
          ),
          title: Text(text),
          onTap: () {
            goRouter.go(route);
          },
        ),
      ),
    );
  }
}
