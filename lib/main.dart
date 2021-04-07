import 'package:flutter/material.dart';
import 'package:tawelti/widgets/addPhotos.dart';
import 'screens/SignInPage.dart';
import 'screens/HomePage.dart';
import 'screens/event/AddEvent.dart';
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
