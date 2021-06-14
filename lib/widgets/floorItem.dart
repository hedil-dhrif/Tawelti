import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class FloorItem extends StatefulWidget {
  final String floorname;
  final int etageId;

  FloorItem({
    this.floorname,
    this.etageId,
  });

  @override
  _FloorItemState createState() => _FloorItemState();
}

class _FloorItemState extends State<FloorItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: GestureDetector(
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
            Icon(
              CupertinoIcons.arrow_right,
              color: Colors.black87,
              size: 28,
            )
          ],
        ),
      ),
    );
  }
}
