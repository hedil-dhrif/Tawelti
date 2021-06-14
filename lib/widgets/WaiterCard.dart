import 'package:flutter/material.dart';
import 'package:tawelti/screens/waiters/DetailWaiter.dart';
import 'package:tawelti/screens/waiters/addWaiter.dart';
import 'package:tawelti/widgets/TowSidedRoundedButton.dart';

import '../constants.dart';

class WaiterCard extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String zone;
  final int waiterId;
  final Function pressDetails;
  final Function pressDelete;

  WaiterCard({this.firstname,this.lastname,this.phoneNumber,this.zone,this.waiterId,this.pressDetails,this.pressDelete});
  @override
  _WaiterCardState createState() => _WaiterCardState();
}

class _WaiterCardState extends State<WaiterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.pressDetails,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.23,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'First name :',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),

                      Text(
                        'Last name :',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),

                      Text(
                        'Phone Number :',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),

                      Text(
                        'adress :',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        widget.firstname,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),

                      Text(
                        widget.lastname,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),

                      Text(
                        widget.phoneNumber,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),

                      Text(
                        widget.zone,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                    ],
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
