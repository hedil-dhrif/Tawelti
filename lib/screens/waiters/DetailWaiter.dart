import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/widgets/DisabledInputbox.dart';

import '../../constants.dart';
import 'WaiterList.dart';

class DetailWaiter extends StatefulWidget {
  @override
  _DetailWaiterState createState() => _DetailWaiterState();
}

class _DetailWaiterState extends State<DetailWaiter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WaiterList()));
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Center(
            child: Text(
              'Detail waiter',
              style: TextStyle(
                  fontSize: 25,
                  color: KBlue,
                  fontFamily: 'ProductSans',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w100),
            ),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              DisabledInputBox(
                label: 'Waiter code: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
              DisabledInputBox(
                label: 'Waiter name: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
              DisabledInputBox(
                label: 'Phone number: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
              DisabledInputBox(
                label: 'Zone: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
