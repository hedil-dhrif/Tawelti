import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tawelti/constants.dart';



void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            SvgPicture.asset(
                'assets/floor-plan.svg',
                color: Colors.white,
              height: 32,
              width: 32,
            ),
            SvgPicture.asset(
              'assets/calendar-multiselect.svg',
              color: Colors.white,
              height: 32,
              width: 32,
            ),
            SvgPicture.asset(
              'assets/plus.svg',
              color: Colors.white,
              height: 32,
              width: 32,
            ),
            SvgPicture.asset(
              'assets/cog-outline.svg',
              color: Colors.white,
              height: 32,
              width: 32,
            ),
            SvgPicture.asset(
              'assets/calendar-star.svg',
              color: Colors.white,
              height: 30,
              width: 30,
            ),
          ],
          color: KBlue,
          buttonBackgroundColor:KBeige ,
          backgroundColor: KBackgroundColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          letIndexChange: (index) => true,
        ),
        );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


