import 'package:dailystep/feature/mypage/view/mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/util/size_util.dart';
import '../home/view/home/home_fragment.dart';

enum TabItem {
  home(
    'assets/icons/home.svg',
    '챌린지',
    HomeFragment(),
  ),
  myPage('assets/icons/my.svg', '마이', MyPageScreen());

  final String icon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.icon, this.tabName, this.firstPage);

  static TabItem find(String? name) {
    return values.asNameMap()[name] ?? TabItem.home;
  }

  BottomNavigationBarItem toNavigationBarItem(BuildContext context,
      {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: isActivated
            ? SvgPicture.asset(
                icon,
                width: 24 * su,
                height: 24 * su,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              )
            : SvgPicture.asset(icon,
                width: 24 * su,
                height: 24 * su,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                )),
        label: tabName);
  }
}
