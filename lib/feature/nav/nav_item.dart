import 'package:dailystep/feature/mypage/view/mypage_screen.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/util/size_util.dart';
import '../home/view/home/home_fragment.dart';

enum TabItem {
  home(WAppIconSvg.homeActive, '챌린지', HomeFragment(), inActiveIcon: WAppIconSvg.homeInactive),
  myPage(WAppIconSvg.personActive, '마이', MyPageScreen(), inActiveIcon: WAppIconSvg.personInactive);

  final String activeIcon;
  final String inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage, {required this.inActiveIcon});


  static TabItem find(String? name){
    return values.asNameMap()[name] ?? TabItem.home;
  }

  BottomNavigationBarItem toNavigationBarItem(BuildContext context, {required bool isActivated}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        isActivated ? activeIcon : inActiveIcon, // Choose the icon based on activation state
        width: 24 * su,
        height: 24 * su,
        colorFilter: ColorFilter.mode(
          isActivated ? WAppColors.black : WAppColors.gray04, // Change color dynamically
          BlendMode.srcIn,
        ),
      ),
      label: tabName,
    );
  }
}
