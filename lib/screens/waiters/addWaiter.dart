import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/screens/waiters/WaiterList.dart';
import 'package:tawelti/screens/waiters/listWaiters.dart';
import 'package:tawelti/constants.dart';

class AddWaiter extends StatefulWidget {
  @override
  _AddWaiterState createState() => _AddWaiterState();
}

class _AddWaiterState extends State<AddWaiter> {
  DateTime _datetime;
  int _counter = 0;
  String valueChoose;
  List listItem = [
    '1st Floor',
    '2nd floor',
    '3rd floor',
    '4th floor',
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

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
                  MaterialPageRoute(builder: (context) => WaiterList()));
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Center(
            child: Text(
              'Add Waiter',
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
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'name',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: KBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'last name',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: KBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Adresse',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: KBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'phone number',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: KBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Zone',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: KBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWaiters()));
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: KBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Add waiter',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: KBackgroundColor,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
