import 'package:flutter/material.dart';
import 'package:tawelti/screens/authentification/GetPassword.dart';
import 'package:tawelti/screens/event/DetailsEvent.dart';
import 'package:tawelti/screens/waitlist/AddWaitlist.dart';
import 'package:tawelti/screens/waitlist/WaitList.dart';
import 'package:tawelti/widgets/addPhotos.dart';
import 'screens/authentification/SignInPage.dart';
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
      home: AddWaitList(),
      routes: {
        "add_event": (_) => AddEvent(),
      },
    );
  }
}
