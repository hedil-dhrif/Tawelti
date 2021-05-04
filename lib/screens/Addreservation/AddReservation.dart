import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/constants.dart';

import '../HomePage.dart';
import 'package:tawelti/screens/Addreservation/AddreservationNext.dart';

class AddReservation extends StatefulWidget {
  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
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
          leading: Icon(CupertinoIcons.arrow_left),
          title: Text(
            'Add Reservation',
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
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Guest number :',
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
                      border: Border.all(width: 1, color: KBlue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$_counter',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_up,
                                size: 30,
                                color: KBlue,
                              ),
                              onTap: _incrementCounter,
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 30,
                                color: KBlue,
                              ),
                              onTap: _decrementCounter,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Pick a date ',
                    style: TextStyle(
                      fontSize: 20,
                      color: KBlue,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: KBlue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: KBlue,
                          size: 30,
                        ),
                        GestureDetector(
                          child: Text(
                            _datetime == null
                                ? 'Nothing has been picked yet'
                                : _datetime.toString(),
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: _datetime == null
                                  ? DateTime.now()
                                  : _datetime,
                              initialDatePickerMode: DatePickerMode.day,
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2040),
                            ).then((date) {
                              setState(() {
                                _datetime = date;
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Floor ',
                    style: TextStyle(
                      fontSize: 20,
                      color: KBlue,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: KBlue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      hint: Text(
                        'Select Floor : ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 35,
                      isExpanded: true,
                      underline: SizedBox(),
                      value: valueChoose,
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue;
                        });
                      },
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                            valueItem,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddReservationNext()));
                    },
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: KBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: KBackgroundColor,
                                  letterSpacing: 2),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 24,
                              color: KBackgroundColor,
                            )
                          ],
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
    );
  }
}
