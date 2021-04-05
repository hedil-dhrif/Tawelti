import 'package:flutter/material.dart';

import '../constants.dart';

class AppBarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.5, color: KBeige)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 20,),
          Text(
            'Add Floor',
            style: TextStyle(
              fontSize: 25,
              color: KBlue,
            ),
          ),
          SizedBox(width: 20,),
          Icon(
            Icons.close,
            size: 25,
            color: KBlue,
          ),
        ],
      ),
    );
  }
}
