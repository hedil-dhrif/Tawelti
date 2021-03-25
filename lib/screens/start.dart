import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Color(0xFF1C3956), BlendMode.dstATop),
              image: ExactAssetImage('assets/background-01.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: [
              Text('Hello')
            ],
          ),
        ),
      ),
    );
  }
}
