import 'package:flutter/material.dart';

import 'package:tawelti/widgets/CustomInputBox.dart';
import 'package:tawelti/widgets/MyCostumTitleWidget.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/SubmitButton.dart';
import 'package:tawelti/screens/HomePage.dart';

class AddRestaurant extends StatelessWidget {
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
                padding: EdgeInsets.only(top: 120),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          KBlue, BlendMode.dstATop),
                      image: ExactAssetImage('assets/uppernejma.png'),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyCostumTitle(
                      MyTitle: 'Welcom to \n TAWELTI',
                      size: 55,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //
                    MyCustomInputBox(
                      label: 'Restaurant Name',
                      inputHint: 'John',
                      color: KBeige,
                    ),
                    //
                    SizedBox(
                      height: 10,
                    ),
                    //
                    MyCustomInputBox(
                      label: 'Location',
                      inputHint: 'tunis, tunis',
                      color: KBeige,
                    ),
                    //
                    SizedBox(
                      height: 10,
                    ),
                    //
                    MyCustomInputBox(
                      label: 'Phone number',
                      inputHint: '22 222 222',
                      color: KBeige,
                    ),
                    //
                    SizedBox(
                      height: 10,
                    ),
                    MyCustomInputBox(
                      label: 'Web site link',
                      inputHint: 'www.restaurant.com',
                      color: KBeige,
                    ),
                    SubmiButton(
                      scrWidth: scrWidth,
                      scrHeight: scrHeight,
                      tap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      title: 'Add Restaurant',
                      bcolor: KBeige,
                      size: 25,
                      color: Color(0xFF333133),
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
