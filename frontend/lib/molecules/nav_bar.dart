import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  int currentPageIndex;
  Function? callback;
  NavBar({super.key, required this.currentPageIndex, this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: NavigationBar(
        onDestinationSelected: (int index) {
          callback!(index);
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: '목록',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.interests),
            icon: Badge.count(count:3, child: Icon(Icons.interests_outlined)),
            label: '조합',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: '마이페이지',
          ),
        ],
      ),
    );
  }
}
