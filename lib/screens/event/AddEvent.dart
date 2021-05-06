import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/screens/event/EventList.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tawelti/widgets/CustomInputBox.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => EventList()));
            },
            icon: Icon(
                CupertinoIcons.arrow_left,
            ),
          ),
          title: Text(
            'Add Event',
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
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.275,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xffE5E5E5),
              ),
              child: _image == null ? IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    color: KBlue,
                    size: 40,
                  ),
                  onPressed: getImage,
              ) : Image.file(
                  _image,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox( height: 15,),
            MyCustomInputBox(
              label: 'Event name',
              inputHint: 'event name',
              color: KBlue,
            ),
            SizedBox( height: 15,),
            MyCustomInputBox(
              label: 'Event description',
              inputHint: 'description ...',
              color: KBlue,
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
          ],
        ),
      ),
    );
  }
}
