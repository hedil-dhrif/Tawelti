import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';

import 'CustomRow.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: Color(0xffF4F4F4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(width: 1.5, color: KBeige)),
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: KBlue,
              backgroundImage: AssetImage('assets/profil.png'),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRow(
                title1: 'Client name: ',
                title2: 'Jhon Doe',
              ),
              SizedBox(
                height: 5,
              ),
              CustomRow(
                title1: 'Reservation Time: ',
                title2: '20:00',
              ),
              SizedBox(
                height: 5,
              ),
              CustomRow(
                title1: 'Zone name: ',
                title2: 'Garden',
              ),
              SizedBox(
                height: 5,
              ),
              CustomRow(
                title1: 'Table number: ',
                title2: 'T21',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
