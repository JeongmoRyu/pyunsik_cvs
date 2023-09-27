import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AlarmButton extends StatefulWidget {
  const AlarmButton({Key? key}) : super(key: key);

  @override
  _AlarmButtonState createState() => _AlarmButtonState();
}

class _AlarmButtonState extends State<AlarmButton> {
  bool _isPopupOpen = false;


  void _togglePopup() {
    setState(() {
      _isPopupOpen = !_isPopupOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter goRouter = GoRouter.of(context);


    return GestureDetector(

      onTap: () {
        if (_isPopupOpen) {
          _togglePopup();
        }


      },
      child: Stack(
        children: [
          PopupMenuButton(
            onSelected: (value) {
              // Handle item selection here
              goRouter.go(value); // Use the value as the route
              _togglePopup();
            },
            icon: Badge.count(count:4, child: Icon(FontAwesomeIcons.bell)),
            // Icon(
            //   FontAwesomeIcons.bell,
            //   color: Colors.black,
            // ),
            offset: Offset(0, kToolbarHeight),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                _buildPopupMenuItem(
                  imageAsset: 'assets/images/gs_logo.png',
                  text: 'GS에서 9개 상품이 할인 중입니다.',
                  route: '/list/filtered',
                  goRouter: goRouter,
                  backgroundColor: Colors.white,
                ),
                _buildPopupMenuItem(
                  imageAsset: 'assets/images/cu_logo.png',
                  text: 'CU에서 10개 상품이 할인 중입니다.',
                  route: '/list/filtered',
                  goRouter: goRouter,
                  backgroundColor: Colors.white,
                ),
                _buildPopupMenuItem(
                  imageAsset: 'assets/images/ministop_logo.png',
                  text: 'MiniStop에서 7개 상품이 할인 중입니다.',
                  route: '/list/filtered',
                  goRouter: goRouter,
                  backgroundColor: Colors.white,
                ),
                _buildPopupMenuItem(
                  imageAsset: 'assets/images/711_logo.jpeg',
                  text: 'SevenEleven에서 5개 상품이 할인 중입니다.',
                  route: '/list/filtered',
                  goRouter: goRouter,
                  backgroundColor: Colors.white,
                ),
              ];
            },
          ),
          if (_isPopupOpen)
            GestureDetector(
              onTap: () {
                _togglePopup();
              },
              child: Container(
                color: Colors.transparent,
                constraints: BoxConstraints.expand(),
              ),
            ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem({
    required String imageAsset,
    required String text,
    required String route,
    required GoRouter goRouter,
    Color? backgroundColor,
  }) {
    return PopupMenuItem<String>(
      value: route,
      child: Container(
        color: backgroundColor,
        child: ListTile(
          leading: Image.asset(
            imageAsset,
            width: 45,
            height: 45,
          ),
          title: Text(text),
        ),
      ),
    );
  }
}
