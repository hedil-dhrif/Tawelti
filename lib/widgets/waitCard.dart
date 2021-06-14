import 'package:flutter/material.dart';
import 'package:tawelti/screens/Reservation/AddReservation.dart';
import 'package:tawelti/screens/Reservation/DetailsReservation.dart';
import 'package:tawelti/widgets/TowSidedRoundedButton.dart';

import '../constants.dart';

class WaitCard extends StatefulWidget {
  final int reservationId;
  final String guestname;
  final String reservationDate;
  final String reservationTime;
  final String nbPersonne;
  final Function delete;
  final Function confirm;


  WaitCard({this.nbPersonne,this.guestname,this.reservationDate,this.reservationTime,this.reservationId,this.delete,this.confirm});
  @override
  _WaitCardState createState() => _WaitCardState();
}

class _WaitCardState extends State<WaitCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
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
                      'guest name:',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    Text(
                      'Reservation date:',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    Text(
                      'Reservation time:',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    Text(
                      'Guest number:',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    // Text(
                    //   'Table code:',
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     color: KBlue,
                    //   ),
                    // ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.guestname,
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    Text(
                      widget.reservationDate,
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    Text(
                      widget.reservationTime,
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    Text(
                      widget.nbPersonne,
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    // Text(
                    //   'T20',
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     color: KBlue,
                    //   ),
                    //),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TwoSideRoundedButton(
                text: 'Confirm',
                press:widget.confirm,
                bottomradious: 0,
                topradious: 20,
                conatinercolor: Color(0xFFF6F6F6),
                textcolor: KBeige,
              ),
              TwoSideRoundedButton(
                text: 'Decline',
                press: widget.delete,
                bottomradious: 20,
                topradious: 0,
                textcolor: Colors.white,
                conatinercolor: KBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
