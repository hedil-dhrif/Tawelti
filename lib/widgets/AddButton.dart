import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/screens/Addfloor/addFloorPage.dart';


class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFloorPage()));
      },
      child: Container(
        height: MediaQuery.of(context).size.height*0.08,
        width: MediaQuery.of(context).size.width*0.6,
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
                Text('Add new floor',style: TextStyle(fontSize: 20,color: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
