import 'package:flutter/material.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/screens/Addreservation/AddreservationNext.dart';
import '../HomePage.dart';
import 'package:intl/intl.dart';

class AddWaitList extends StatefulWidget {
  @override
  _AddWaitListState createState() => _AddWaitListState();
}

class _AddWaitListState extends State<AddWaitList> {
  DateTime datetime;

  String getText() {
    if (datetime == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd/MM/yyyy').format(datetime);
    }
  }

  TimeOfDay time;

  String getTextTime() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() => time = newTime);
  }

  int _counter = 0;
  String valueChoose;
  List listItem = [
    '1st Floor',
    '2nd floor',
    '3rd floor',
    '4th floor',
  ];

  String valueChoose2;
  List listItem2 = [
    'Garden',
    'Outdoor',
    'Indoor',
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AppBarWidget(
          title: 'Add to wait list',
          onpressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Guest Name :',
                      style: TextStyle(
                        fontSize: 25,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 20,
                            color: KBlue,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'JhonDoe',
                          hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[350],
                              fontWeight: FontWeight.w600),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                          focusColor: KBlue,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: KBlue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: KBlue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Guest number :',
                      style: TextStyle(
                        fontSize: 25,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                              fontSize: 30,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pick a date :',
                              style: TextStyle(
                                fontSize: 25,
                                color: KBlue,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.4,
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
                                      getText(),
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate:
                                        datetime == null ? DateTime.now() : datetime,
                                        initialDatePickerMode: DatePickerMode.day,
                                        firstDate: DateTime(2021),
                                        lastDate: DateTime(2040),
                                      ).then((date) {
                                        setState(() {
                                          datetime = date;
                                        });
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pick time :',
                              style: TextStyle(
                                fontSize: 25,
                                color: KBlue,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.4,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: KBlue),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: KBlue,
                                    size: 30,
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      getTextTime(),
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    onTap: () {
                                      pickTime(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Floor :',
                      style: TextStyle(
                        fontSize: 25,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                      height: 20,
                    ),
                    Text(
                      'Zone :',
                      style: TextStyle(
                        fontSize: 25,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: KBlue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(
                        hint: Text(
                          'Select Zone : ',
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
                        value: valueChoose2,
                        onChanged: (newValue) {
                          setState(() {
                            valueChoose2 = newValue;
                          });
                        },
                        items: listItem2.map((valueItem) {
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
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddReservationNext()));
                      },
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
                                  fontSize: 30,
                                  color: KBackgroundColor,
                                  letterSpacing: 2),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 30,
                              color: KBackgroundColor,
                            )
                          ],
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
