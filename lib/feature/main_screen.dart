import 'package:dailystep/common/extension/mun_duration_extension.dart';
import 'package:dailystep/common/util/flutter_async.dart';
import 'package:dailystep/feature/tab/tab_item.dart';
import 'package:dailystep/feature/tab/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nav/nav.dart';
import 'package:velocity_x/velocity_x.dart';


final currentTabProvider = StateProvider<TabItem>((ref) => TabItem.home);

class MainScreen extends ConsumerStatefulWidget {
  final TabItem firstTab;
  const MainScreen( {super.key, this.firstTab = TabItem.home});

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen>
    with SingleTickerProviderStateMixin {

  TabItem get _currentTab => ref.watch(currentTabProvider);
  int get _currentIndex => tabs.indexOf(_currentTab);

  final tabs = [
    TabItem.home,
    TabItem.calendar,
    TabItem.chart,
    TabItem.myPage,
  ];
  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  GlobalKey<NavigatorState> get _currentTabNavigationKey =>
      navigatorKeys[_currentIndex];

  static double get bottomNavigationBarBorderRadius => 30.0;
  static const bottomNavigationBarHeight = 60.0;

  @override
  void initState() {
    super.initState();
    initNavigatorKeys();
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    if(oldWidget.firstTab != widget.firstTab){
      delay((){
        ref.read(currentTabProvider.notifier).state = widget.firstTab;
      }, 0.ms);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PopScope(
        canPop: isRootPage,
        onPopInvokedWithResult: _handleBackPressed,
        child: Stack(
            children: [
              Scaffold(
                  body: Container(
                    padding: EdgeInsets.only(bottom: 60 -
                        bottomNavigationBarBorderRadius),
                    child: SafeArea(
                      child: pages,
                    ),
                  ),
                  bottomNavigationBar: _buildBottomNavigationBar(context)
              ),
              AnimatedOpacity(opacity: _currentTab == TabItem.home ? 1 : 0,
                duration: 200.ms,
                child: const SizedBox(),)///floatingButton
            ]
        ),
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

  void _handleBackPressed(bool didPop,_) {
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
    return Container(
      height: bottomNavigationBarHeight,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(bottomNavigationBarBorderRadius),
          topRight: Radius.circular(bottomNavigationBarBorderRadius),
        ),
        child: BottomNavigationBar(
          items: navigationBarItems(context),
          currentIndex: _currentIndex,
          onTap: _handleOnTapNavigationBarItem,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
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
    ref.read(currentTabProvider.notifier).state = tabs[index];
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