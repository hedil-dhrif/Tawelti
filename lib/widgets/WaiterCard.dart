import 'package:flutter/material.dart';
import 'package:tawelti/screens/waiters/DetailWaiter.dart';
import 'package:tawelti/screens/waiters/addWaiter.dart';
import 'package:tawelti/widgets/TowSidedRoundedButton.dart';

import '../constants.dart';

class WaiterCard extends StatefulWidget {
  @override
  _WaiterCardState createState() => _WaiterCardState();
}

class _WaiterCardState extends State<WaiterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailWaiter()));
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
                        'Waiter code:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Name :',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Phone Number:',
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
                        '11111111',
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
                        MaterialPageRoute(builder: (context) => AddWaiter()));
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
