// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../models/cart.dart';
//
// //not used
// class NavBar extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onDestinationSelected;
//
//   const NavBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onDestinationSelected
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var cart = context.watch<Cart>();
//
//     return SizedBox(
//       height: 60,
//       child: NavigationBar(
//         onDestinationSelected: onDestinationSelected,
//         selectedIndex: selectedIndex,
//         destinations: <Widget>[
//           const NavigationDestination(
//             selectedIcon: Icon(Icons.home),
//             icon: Icon(Icons.home_outlined),
//             label: '홈',
//           ),
//           const NavigationDestination(
//             icon: Icon(Icons.list),
//             label: '목록',
//           ),
//           NavigationDestination(
//             selectedIcon: Icon(Icons.interests),
//             icon: Badge.count(count: cart.numberOfProducts, child: Icon(Icons.interests_outlined)),
//             label: '조합',
//           ),
//           const NavigationDestination(
//             selectedIcon: Icon(Icons.person),
//             icon: Icon(Icons.person_outlined),
//             label: '마이페이지',
//           ),
//         ],
//       ),
//     );
//   }
// }
