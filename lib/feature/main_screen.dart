import 'package:dailystep/common/extension/list_extension.dart';
import 'package:dailystep/common/extension/mun_duration_extension.dart';
import 'package:dailystep/common/util/flutter_async.dart';
import 'package:dailystep/feature/nav/nav_item.dart';
import 'package:dailystep/feature/nav/nav_navigator.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nav/nav.dart';

import '../common/util/size_util.dart';
import '../widgets/widget_confirm_modal.dart';
import 'home/viewmodel/challenge_viewmodel.dart';

final currentTabProvider = StateProvider<TabItem>((ref) => TabItem.home);

class MainScreen extends ConsumerStatefulWidget {
  final TabItem firstTab;
  final int? id;

  const MainScreen({super.key, this.firstTab = TabItem.home, this.id,});

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen>
    with SingleTickerProviderStateMixin {
  TabItem get _currentTab => ref.watch(currentTabProvider);

  int get _currentIndex => tabs.indexOf(_currentTab);

  final tabs = [
    TabItem.home,
    TabItem.myPage,
  ];
  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  GlobalKey<NavigatorState> get _currentTabNavigationKey =>
      navigatorKeys[_currentIndex];
  static var bottomNavigationBarHeight = 60.0 * su;

  @override
  void initState() {
    super.initState();
    initNavigatorKeys();
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    if (oldWidget.firstTab != widget.firstTab) {
      delay(() {
        ref
            .read(currentTabProvider.notifier)
            .state = widget.firstTab;
      }, 0.ms);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(challengeViewModelProvider);
    return Material(
      child: PopScope(
        canPop: isRootPage,
        onPopInvokedWithResult: _handleBackPressed,
        child: Stack(children: [
          Scaffold(
            body: Container(
              child: SafeArea(
                child: pages,
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(context),
            floatingActionButton: state.when(
                data: (data) => FloatingActionButton(
                    onPressed: () {
                      ///진행중인 챌리지가 5개 이하인 경우에만 추가 가능
                      if(data.onGoingChallengeCount < 5){
                        context.go('/main/challenge/new');
                      } else {
                        showConfirmModal(
                            context: context,
                            content: Column(
                              children: [
                                Text(
                                  '챌린지 등록 개수 초과',
                                  style: boldTextStyle,
                                ),
                                height5,
                                Text(
                                  '진행중인 챌린지는 5개까지 등록할 수 있어요',
                                  style: subTextStyle,
                                )
                              ],
                            ),
                            confirmText: '닫기',
                            onClickConfirm: (){},
                            isCancelButton: false);
                      }
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
                error: (Object error, StackTrace stackTrace) => SizedBox(),
                loading: () => SizedBox()),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
          ),
        ]),
      ),
    );
  }

  bool get isRootPage =>
      _currentTab == TabItem.home &&
          _currentTabNavigationKey.currentState?.canPop() == false;

  IndexedStack get pages =>
      IndexedStack(
          index: _currentIndex,
          children: tabs
              .mapIndexed((tab, index) =>
              Offstage(
                offstage: _currentTab != tab,
                child: TabNavigator(
                  navigatorKey: navigatorKeys[index],
                  tabItem: tab,
                ),
              ))
              .toList());

  void _handleBackPressed(bool didPop, _) {
    if (!didPop) {
      if (_currentTabNavigationKey.currentState?.canPop() == true) {
        Nav.pop(_currentTabNavigationKey.currentContext!);
        return;
      }

      if (_currentTab != TabItem.home) {
        _changeTab(tabs.indexOf(TabItem.home));
      }
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: WAppColors.gray03, // 회색 테두리 색상
              width: 1.0, // 테두리 두께
            ),
          ),
        ),
        height: bottomNavigationBarHeight,
        child: BottomNavigationBar(
          items: navigationBarItems(context),
          currentIndex: _currentIndex,
          onTap: _handleOnTapNavigationBarItem,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          selectedLabelStyle: WAppFontSize.navbar(),
          unselectedLabelStyle: WAppFontSize.navbar(color: WAppColors.gray05),
          elevation: 0,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> navigationBarItems(BuildContext context) {
    return tabs
        .mapIndexed(
          (tab, index) =>
          tab.toNavigationBarItem(
            context,
            isActivated: _currentIndex == index,
          ),
    )
        .toList();
  }

  void _changeTab(int index) {
    ref
        .read(currentTabProvider.notifier)
        .state = tabs[index];
  }

  BottomNavigationBarItem bottomItem(bool activate, IconData iconData,
      IconData inActivateIconData, String label) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(label),
          activate ? iconData : inActivateIconData,
        ),
        label: label);
  }

  void _handleOnTapNavigationBarItem(int index) {
    final oldTab = _currentTab;
    final targetTab = tabs[index];
    if (oldTab == targetTab) {
      final navigationKey = _currentTabNavigationKey;
      popAllHistory(navigationKey);
    }
    _changeTab(index);
  }

  void popAllHistory(GlobalKey<NavigatorState> navigationKey) {
    final bool canPop = navigationKey.currentState?.canPop() == true;
    if (canPop) {
      while (navigationKey.currentState?.canPop() == true) {
        navigationKey.currentState!.pop();
      }
    }
  }

  void initNavigatorKeys() {
    for (final _ in tabs) {
      navigatorKeys.add(GlobalKey<NavigatorState>());
    }
  }
}
