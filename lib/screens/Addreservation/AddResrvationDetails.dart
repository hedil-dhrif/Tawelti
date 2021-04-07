import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/CustomInputBox.dart';
import 'package:tawelti/widgets/SubmitButton.dart';

class AddReservationDetails extends StatefulWidget {
  @override
  _AddReservationDetailsState createState() => _AddReservationDetailsState();
}

class _AddReservationDetailsState extends State<AddReservationDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: KBlue,
        ),
        title: AppBarWidget(
          title: 'Add reservation',
          icon: Icons.close,
          onpressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyCustomInputBox(
                label: 'Restaurant Name',
                inputHint: 'John',
                color: KBeige,
              ),
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
                scrWidth: MediaQuery.of(context).size.width,
                scrHeight: MediaQuery.of(context).size.height,
                tap: () {
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));*/
                },
                title: 'Add Restaurant',
                bcolor: KBeige,
                size: 25,
                color: Color(0xFF333133),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
