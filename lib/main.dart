import 'package:flutter/material.dart';
import 'package:tawelti/screens/AddWaitlist.dart';
import 'screens/SignInPage.dart';
import 'screens/Addreservation/AddReservationNext.dart';
import 'screens/WaitList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddReservationNext(),
    );
  }
}
