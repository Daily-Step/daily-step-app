import 'package:dailystep/feature/mypage/view/mypage_screen.dart';
import 'package:flutter/material.dart';
import '../home/view/home/home_fragment.dart';

enum TabItem {
  home(Icons.home, '챌린지', HomeFragment(), inActiveIcon: Icons.home_outlined),
  myPage(Icons.person, '마이', MyPageScreen(), inActiveIcon: Icons.person_outline);

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage, {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  static TabItem find(String? name){
    return values.asNameMap()[name] ?? TabItem.home;
  }

  BottomNavigationBarItem toNavigationBarItem(BuildContext context, {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          isActivated ? activeIcon : inActiveIcon,
          color: isActivated ? Colors.black : Colors.grey,
        ),
        label: tabName
    );
  }
}
