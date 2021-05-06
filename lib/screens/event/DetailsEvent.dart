import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/screens/event/EventList.dart';
import 'package:tawelti/widgets/DisabledInputbox.dart';
import 'package:tawelti/widgets/ImageBox.dart';

class DetailsEvent extends StatefulWidget {

  @override
  _DetailsEventState createState() => _DetailsEventState();
}

class _DetailsEventState extends State<DetailsEvent> {
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
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EventList()));
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Text(
            'Event list',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/events.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DisabledInputBox(
              label: 'Event name: ',
              inputHint: 'XXXXX',
              color: KBlue,
            ),
            DisabledInputBox(
              label: 'Event description: ',
              inputHint: 'lorem ipsium ...',
              color: KBlue,
            ),
            DisabledInputBox(
              label: 'Start at:',
              inputHint: '20:00',
              color: KBlue,
            ),
            DisabledInputBox(
              label: 'End at:',
              inputHint: '22:00',
              color: KBlue,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Text(
                'Event images : ',
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  fontSize: 20,
                  color: Color(0xff8f9db5),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ImageBox(),
                  SizedBox(
                    width: 20,
                  ),
                  ImageBox(),
                  SizedBox(
                    width: 20,
                  ),
                  ImageBox(),
                  SizedBox(
                    width: 20,
                  ),
                  ImageBox(),
                  SizedBox(
                    width: 20,
                  ),
                  ImageBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
