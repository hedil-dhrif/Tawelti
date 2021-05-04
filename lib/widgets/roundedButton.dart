import 'package:flutter/material.dart';
import 'package:tawelti/screens/Addfloor/addFloorPage.dart';
import 'package:tawelti/screens/Addreservation/AddReservation.dart';
import 'package:tawelti/screens/event/AddEvent.dart';
import 'package:tawelti/screens/event/DetailsEvent.dart';

class RoundedButton extends StatefulWidget {
  final Color color;
  // final double height;
  // final double width;
  final double radius;
  final Widget icon;

  RoundedButton({this.color, this.radius, this.icon});
  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 0.4,
      child: FlatButton(
        child: Container(
          //color: Colors.white,
          // height: widget.height,
          // width: widget.width,
          child: CircleAvatar(
            backgroundColor: widget.color,
            radius: widget.radius,
            child: widget.icon,
          ),
        ),
      ),
    );
  }



}
