import 'package:flutter/material.dart';


class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black87,
            radius: 70,
            child: Text('M'),
          ),
          Positioned(
            top: 100,
            left: 90,
            child: CircleAvatar(
                backgroundColor: Color(0xffF4F4F4).withOpacity(0.5),
                child: Icon(Icons.camera_alt_rounded,color: Color(0xffC4C4C4),size: 32,)),
          ),
        ],
      ),
    );
  }
}
