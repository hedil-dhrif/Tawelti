import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/screens/Addfloor/tableDetails.dart';

class TableItem2 extends StatefulWidget {
  final String index;
  final int etat;
  final Function deleteFunction;
  TableItem2({this.index,this.etat,this.deleteFunction});
  @override
  _TableItem2State createState() => _TableItem2State();
}

class _TableItem2State extends State<TableItem2> {
  Color getColor(){
    switch (widget.etat) {
      case 0:
        return  Colors.green;

        break;
      case 1:
        return Colors.red;
        break;
      case -1:
        return Colors.blueGrey;
        break;
      default:
        return Colors.green;
    }
  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onDoubleTap: () {
        _deleteDialog();
      },

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: KBlue,
        ),
        height: 60,
        width: 100,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: getColor(),
          child: Text(widget.index),
        ),
      ),
    );
  }



  Future<void> _deleteDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffF4F4F4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Are you sure you want to remove this table',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      ),
                      Container(
                        width: 10,
                        color: Colors.grey,
                      ),
                      TextButton(
                        child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                        ),
                        onPressed: widget.deleteFunction,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}






