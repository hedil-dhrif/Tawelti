import 'package:flutter/material.dart';
import 'package:tawelti/widgets/CustomInputBox.dart';
import 'package:tawelti/widgets/MyCostumTitleWidget.dart';
import 'package:tawelti/constants.dart';
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
      ),
    );
  }
}
