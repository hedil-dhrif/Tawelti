import 'package:flutter/material.dart';
import 'package:tawelti/screens/Addfloor/FloorDetailsPage.dart';
import 'package:tawelti/screens/Addfloor/test.dart';
import 'package:tawelti/screens/Addfloor/wrapList.dart';
import 'package:tawelti/screens/Addfloor/zonePlan.dart';
import 'package:tawelti/screens/authentification/SignInPage.dart';
import 'package:tawelti/screens/dashboard.dart';
import 'screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}
