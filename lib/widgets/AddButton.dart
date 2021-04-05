import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';


class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: KBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.add,size: 25,color: Colors.white,),
                Text('Add new floor',style: TextStyle(fontSize: 15,color: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
