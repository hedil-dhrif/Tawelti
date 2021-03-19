import 'package:flutter/material.dart';
import 'package:tawelti/widgets/CustomInputBox.dart';
import 'package:tawelti/widgets/MyCostumTitleWidget.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/screens/SignUpPage.dart';
import 'package:tawelti/widgets/SubmitButton.dart';
import 'package:tawelti/screens/AddRestaurantPage.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
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
                    SizedBox(
                      height: 40,
                    ),
                    //
                    MyCustomInputBox(
                      label: 'Name',
                      inputHint: 'John',
                      color: KBlue,
                    ),
                    //
                    SizedBox(
                      height: 15,
                    ),
                    //
                    MyCustomInputBox(
                      label: 'Password',
                      inputHint: '8+ Characters,1 Capital letter',
                      color: KBlue,
                    ),
                    //
                    SizedBox(
                      height: 15,
                    ),
                    //
                    Text(
                      "Creating an account means you're okay with\nour Terms of Service and Privacy Policy",
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8f9db5).withOpacity(0.45),
                      ),
                      //
                    ),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account! ',
                              style: TextStyle(
                                fontFamily: 'Product Sans',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff8f9db5).withOpacity(0.45),
                              ),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                fontFamily: 'Product Sans',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: KBlue,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
