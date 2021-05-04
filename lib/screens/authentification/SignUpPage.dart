import 'package:flutter/material.dart';
import 'package:tawelti/widgets/CustomInputBox.dart';
import 'package:tawelti/widgets/MyCostumTitleWidget.dart';
import 'package:tawelti/constants.dart';
//import 'file:///C:/Users/ASUSI7/AndroidStudioProjects/tawelti/lib/screens/authentification/SignInPage.dart';
import 'package:tawelti/screens/AddRestaurantPage.dart';
import 'package:tawelti/widgets/SubmitButton.dart';

class SignUpPage extends StatelessWidget {
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
                padding: EdgeInsets.only(top: 80),
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
                  children: [
                    MyCostumTitle(
                      MyTitle: 'Sign Up',
                      size: 60,
                    ),
                    SizedBox(
                      height: 15,
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
                      label: 'Email',
                      inputHint: 'example@example.com',
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remember me",
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8f9db5).withOpacity(0.45),
                          ),
                          //
                        ),
                        SizedBox(width: 80,),
                        Text(
                          "Forgot password",
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8f9db5).withOpacity(0.45),
                          ),
                          //
                        ),
                      ],
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
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => SignIn()));
                      // },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                fontFamily: 'Product Sans',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff8f9db5).withOpacity(0.45),
                              ),
                            ),
                            TextSpan(
                              text: 'Sign In',
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
