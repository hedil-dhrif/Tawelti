import 'package:flutter/material.dart';
import 'package:tawelti/screens/SignInPage.dart';
import 'screens/start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
    );
  }
}
