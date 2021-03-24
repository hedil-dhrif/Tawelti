import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1.5, color: KBeige)),
        ),
        child: Row(
          children: [
            IconButton(
                //icon: Icon(),
                onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}
