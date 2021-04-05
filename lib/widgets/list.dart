import 'package:flutter/material.dart';
import 'package:tawelti/widgets/floorItem.dart';

class listFloor extends StatefulWidget {
  @override
  _listFloorState createState() => _listFloorState();
}

class _listFloorState extends State<listFloor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:   ListView.separated(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return  FloorItem(floorname: 'ghj',zoneNumber: '3',tableNumber: 0);

          },
          separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black87,),),
    );
  }
}
