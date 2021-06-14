import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:tawelti/screens/dashboard.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/AddButton.dart';
import 'package:tawelti/widgets/navBar.dart';
import 'package:tawelti/widgets/navbar2.dart';
import 'package:tawelti/widgets/roundedButton.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xf6f6f6),
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading:Icon(CupertinoIcons.arrow_left),
          title: Text('Floor Plan',          style: TextStyle(color: Colors.black87, fontSize: 24),
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.08),
            child: Divider(
              thickness: 2,
              color: KBeige,
            ),
          ),
        ),
      ),

      body: Center(
        child: Center(
          child: AddButton(),
        )
      ),
    );
  }
}
