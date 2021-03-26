import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';

class AppBarWidget extends StatefulWidget {

  String title;
  IconData icon;
  Function onpressed;

  AppBarWidget({this.title, this.icon, this.onpressed});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.5, color: KBeige)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: KBlue,
            backgroundImage: AssetImage('assets/profil.png'),
          ),
          SizedBox(width: 20,),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 25,
              color: KBlue,
            ),
          ),
          SizedBox(width: 20,),
          IconButton(
            onPressed: widget.onpressed,
            icon: Icon(
              widget.icon,
              size: 25,
              color: KBlue,
            ),
          ),
        ],
      ),
    );
  }
}
