import 'package:flutter/material.dart';
import 'package:tawelti/screens/Addfloor/addFloorPage.dart';
import 'package:tawelti/screens/Addreservation/AddReservation.dart';

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
        onPressed: _showMyDialog,
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextButton(
                  child: Text(
                    'Add Floor',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return AddFloorPage();
                    }));
                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black54,
                ),
                TextButton(
                  child: Text(
                    'Add reservation',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return AddReservation();
                        }));
                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black54,
                ),
                TextButton(
                  child: Text(
                    'Add event',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
