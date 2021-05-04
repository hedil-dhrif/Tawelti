import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ListWaiters extends StatefulWidget {
  @override
  _ListWaitersState createState() => _ListWaitersState();
}

class _ListWaitersState extends State<ListWaiters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Color(0xf6f6f6),
            iconTheme: IconThemeData(
              color: KBlue,
            ),
            leading: Icon(CupertinoIcons.arrow_left),
            title: Text(
              'List Waiters',
              style: TextStyle(
                  fontSize: 25,
                  color: KBlue,
                  fontFamily: 'ProductSans',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w100),
            ),
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.08),
              child: Divider(
                thickness: 2,
                color: KBeige,
              ),
            ),
          ),
        ),
        body: Container(
      child: Center(child: Text('waiters')),
    ));
  }


}
