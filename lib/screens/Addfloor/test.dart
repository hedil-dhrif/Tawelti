import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tawelti/screens/HomePage.dart';
import 'package:tawelti/screens/Reservation/ReservationList.dart';
import 'package:tawelti/screens/dashboard.dart';
import 'package:tawelti/screens/event/EventList.dart';
import 'package:tawelti/screens/waiters/WaiterList.dart';
import 'package:tawelti/screens/waiters/addWaiter.dart';

import '../../constants.dart';
import 'addFloorPage.dart';

class Test extends StatelessWidget {
  const Test({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        MainPage(),
        HomePage(),
        ReservationtList(),
        WaiterList(),
        EventList()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Acceuil"),
          activeColorPrimary: KBlue,
          inactiveColorPrimary: KBeige,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.rectangle_3_offgrid),
          title: ("Plan"),
          activeColorPrimary: KBlue,
          inactiveColorPrimary: KBeige,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.calendar_today),
          title: ("Reservations"),
          activeColorPrimary: KBlue,
          inactiveColorPrimary: KBeige,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person_2),
          title: ("serveurs"),
          activeColorPrimary: KBlue,
          inactiveColorPrimary: KBeige,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.star_circle),
          title: ("evenements"),
          activeColorPrimary: KBlue,
          inactiveColorPrimary: KBeige,
        ),
      ];
    }

    return Scaffold(

      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
}
