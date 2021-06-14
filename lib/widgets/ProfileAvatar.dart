import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';


class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Stack(
        children: [
          CircleAvatar(
            backgroundColor: KBlue,
            radius: 60,
            backgroundImage: AssetImage('assets/profil.png'),
          ),
          Positioned(
            top: 80,
            left: 80,
            child: CircleAvatar(
                backgroundColor: Color(0xffF4F4F4).withOpacity(0.5),
                child: Icon(Icons.camera_alt_rounded,color: Color(0xffC4C4C4),size: 32,)),
          ),
        ],
      ),
    );
  }
}
