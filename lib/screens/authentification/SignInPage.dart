import 'package:flutter/material.dart';
import 'package:tawelti/screens/authentification/GetPassword.dart';
import 'package:tawelti/widgets/CustomInputBox.dart';
import 'package:tawelti/widgets/MyCostumTitleWidget.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/SubmitButton.dart';
import 'package:tawelti/screens/AddRestaurantPage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 150),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Color(0xFFFEFEFE), BlendMode.dstATop),
                    image: ExactAssetImage('assets/uppernejma.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCostumTitle(
                    MyTitle: 'Sign In',
                    size: 60,
                  ),
                  MyCustomInputBox(
                    label: 'Name',
                    inputHint: 'John',
                    color: KBlue,
                  ),
                  MyCustomInputBox(
                    label: 'Password',
                    inputHint: '8+ Characters,1 Capital letter',
                    color: KBlue,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetPassword()));
                    },
                    child: Text(
                      'forgot my password',
                      style: TextStyle(
                        fontSize: 15,
                        color: KBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                  SubmiButton(
                    scrWidth: scrWidth,
                    scrHeight: scrHeight,
                    tap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddRestaurant()));
                    },
                    title: 'Create Account',
                    bcolor: KBlue,
                    size: 20,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
