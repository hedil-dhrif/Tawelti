import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/screens/Addfloor/FloorDetailsPage.dart';

import '../constants.dart';

class FloorItem extends StatefulWidget {
  final String floorname;
  final String zoneNumber;
  final int tableNumber;

  FloorItem({
    this.floorname,
    this.tableNumber,
    this.zoneNumber,
  });

  @override
  _FloorItemState createState() => _FloorItemState();
}

class _FloorItemState extends State<FloorItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return FloorDetailsPage();
            },
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Center(
                  child: CustomSwitchButton(
                    backgroundColor: KBeige,
                    unCheckedColor: Colors.white,
                    animationDuration: Duration(milliseconds: 400),
                    checkedColor: KBlue,
                    checked: isChecked,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.floorname,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Text(widget.zoneNumber.toString(),
              style: TextStyle(
                fontSize: 20,
              )),
          Text(widget.tableNumber.toString(),
              style: TextStyle(
                fontSize: 20,
              )),
          Icon(
            Icons.delete_outline,
            color: Colors.black87,
            size: 28,
          )
        ],
      ),
    );
  }
}
