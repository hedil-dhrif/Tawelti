import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelti/models/Restaurant.dart';
import 'package:tawelti/screens/HomePage.dart';
import 'package:tawelti/screens/Reservation/ReservationList.dart';
import 'package:tawelti/screens/dashboard.dart';
import 'package:tawelti/screens/event/EventList.dart';
import 'package:tawelti/screens/waiters/WaiterList.dart';
import 'package:tawelti/screens/waiters/addWaiter.dart';
import 'package:tawelti/screens/waitlist/WaitList.dart';
import 'package:tawelti/services/user.services.dart';

import '../../constants.dart';
import 'addFloorPage.dart';

class Test extends StatefulWidget {
  const Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  UserServices get userService => GetIt.I<UserServices>();
  @override
  void initState() {
    _getUserInfo();
    //_fetchReservations();
    super.initState();
  }

  String errorMessage;
  bool _isLoading = false;


  TextEditingController NameController = TextEditingController();
  bool _isEnabled = false;
  var user;
  int Id;
  Restaurant restaurant;

  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var userId = localStorage1.getInt('id');
    print(userId);
    setState(() {
      user = userId;
     // _getUserRestaurant(user);
      print(user);
    });
  }
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        AddFloorPage(),
        ReservationtList(),
        WaitList(restaurantID: 33,),
        WaiterList(restaurantID: 33,),
        EventList(restaurantId: 33,)
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
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
          icon: Icon(CupertinoIcons.calendar_badge_plus),
          title: ("WaitList"),
          activeColorPrimary: KBlue,
          inactiveColorPrimary: KBeige,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person_2),
          title: ("waiters"),
          activeColorPrimary: KBlue,
          inactiveColorPrimary: KBeige,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.star_circle),
          title: ("events"),
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

  // _getUserRestaurant(userId) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await userService.getUserRestauarnt(userId.toString()).then((response) {
  //     if (response.error) {
  //       errorMessage = response.errorMessage ?? 'An error occurred';
  //     }
  //     restaurant = response.data;
  //     print(restaurant.id);
  //     print(restaurant.NomResto);
  //     print(restaurant.id);
  //     print(restaurant.adresse);
  //     print(restaurant.Description);
  //     setState(() {
  //       _isLoading = false;
  //     });
  //
  //     // _titleController.text = floor.nom;
  //     //_contentController.text = note.noteContent;
  //   });
  // }
}
