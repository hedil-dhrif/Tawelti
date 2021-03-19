import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, bottom: 15),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1.5, color: KBeige)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: KBlue,
                  backgroundImage: AssetImage('assets/profil.png'),
                ),
                SizedBox(width: 20,),
                Text(
                    'Restaurant Name',
                  style: TextStyle(
                    fontSize: 30,
                    color: KBlue,
                  ),
                ),
                SizedBox(width: 20,),
                Icon(
                  Icons.menu_rounded,
                  size: 30,
                  color: KBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}