import 'package:flutter/material.dart';

import '../home/view/home_fragment.dart';

enum TabItem {
  home(Icons.home, '홈', HomeFragment()),
  calendar(Icons.calendar_month, '캘린더', HomeFragment()),
  chart(Icons.pie_chart, '통계', HomeFragment()),
  myPage(Icons.person, '마이페이지', HomeFragment());

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
        ),
        label: tabName);
  }
}
