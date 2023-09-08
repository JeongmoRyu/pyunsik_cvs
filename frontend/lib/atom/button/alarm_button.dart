// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
//
// PopupMenuButton(
//   icon: Icon(
//     FontAwesomeIcons.bell,
//     color: Colors.black,
//   ),
//   offset: Offset(0, kToolbarHeight), // 이 옵션을 사용하여 팝업 메뉴의 위치를 조정합니다.
//   itemBuilder: (BuildContext context) {
//     return <PopupMenuEntry>[
//       PopupMenuItem(
//         child: ListTile(
//           leading: Icon(Icons.notifications),
//           title: Text('GS에서 9개 상품이 할인 중입니다.'),
//           onTap: () {
//             goRouter.go('/firstlist');
//           },
//         ),
//       ),
//       PopupMenuItem(
//         child: ListTile(
//           leading: Icon(Icons.notifications),
//           title: Text('CU에서 10개 상품이 할인 중입니다.'),
//         onTap: () {
//           goRouter.go('/firstlist');
//           },
//         ),
//       ),
//       PopupMenuItem(
//         child: ListTile(
//           leading: Icon(Icons.notifications),
//           title: Text('MiniStop에서 7개 상품이 할인 중입니다.'),
//           onTap: () {
//             goRouter.go('/firstlist');
//             },
//           ),
//         ),
//       PopupMenuItem(
//         child: ListTile(
//           leading: Icon(Icons.notifications),
//           title: Text('SevenEleven에서 5개 상품이 할인 중입니다.'),
//           onTap: () {
//             goRouter.go('/firstlist');
//           },
//         ),
//       )
//
//     ];
//   },
// )