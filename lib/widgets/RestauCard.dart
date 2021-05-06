import 'package:flutter/material.dart';
import 'package:tawelti/screens/Reservation/AddReservation.dart';
import 'package:tawelti/screens/Reservation/DetailsReservation.dart';
import 'package:tawelti/screens/event/AddEvent.dart';
import 'package:tawelti/screens/event/DetailsEvent.dart';
import 'package:tawelti/widgets/TowSidedRoundedButton.dart';

import '../constants.dart';

class RestauCard extends StatefulWidget {
  @override
  _RestauCardState createState() => _RestauCardState();
}

class _RestauCardState extends State<RestauCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailReservation()));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
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
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reservation code:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'guest name:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Reservation time:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Zone:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Table code:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'XXXXXXX',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Jhon Doe',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '20:00',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'outSide',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'T20',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TwoSideRoundedButton(
                  text: 'Edit',
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddReservation()));
                  },
                  bottomradious: 0,
                  topradious: 20,
                  conatinercolor: Color(0xFFF6F6F6),
                  textcolor: KBeige,
                ),
                TwoSideRoundedButton(
                  text: 'Delete',
                  press: () {},
                  bottomradious: 20,
                  topradious: 0,
                  textcolor: Colors.white,
                  conatinercolor: KBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
