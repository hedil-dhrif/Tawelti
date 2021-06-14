import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/event.dart';
import 'package:tawelti/screens/event/EventList.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tawelti/services/event.services.dart';
import 'package:tawelti/widgets/CustomInputBox.dart';

class AddEvent extends StatefulWidget {
  final restauarntId;
  final int eventId;
  AddEvent({this.eventId,this.restauarntId});
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  bool get isEditing => widget.eventId != null;
  EventServices get eventsService => GetIt.I<EventServices>();
  String errorMessage;
  Event event;
  bool _isLoading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  File _image;
  bool _validate = false;
  final picker = ImagePicker();
  @override
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

  DateTime dateDebut;
  DateTime dateFin;

  String getText(date) {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EventList()));
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
              child: _image == null
                  ? IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        color: KBlue,
                        size: 40,
                      ),
                      onPressed: getImage,
                    )
                  : Image.file(
                      _image,
                      fit: BoxFit.fill,
                    ),
            ),
            SizedBox(
              height: 15,
            ),
            MyCustomInputBox(
              validate:_validate ,
              controller: _nameController,
              label: 'Event name',
              inputHint: 'event name',
              color: KBlue,
            ),
            SizedBox(
              height: 15,
            ),
            MyCustomInputBox(
              validate:_validate ,
              controller: _descriptionController,
              label: 'Event description',
              inputHint: 'description ...',
              color: KBlue,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick a start date :',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: KBlue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: KBlue,
                            size: 30,
                          ),
                          GestureDetector(
                            child: Text(
                              getText(dateDebut),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate:
                                dateDebut == null ? DateTime.now() : dateDebut,
                                initialDatePickerMode: DatePickerMode.day,
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2040),
                              ).then((date) {
                                setState(() {
                                  dateDebut = date;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick an end date :',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: KBlue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: KBlue,
                            size: 30,
                          ),
                          GestureDetector(
                            child: Text(
                              getText(dateFin),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate:
                                dateFin == null ? DateTime.now() : dateFin,
                                initialDatePickerMode: DatePickerMode.day,
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2040),
                              ).then((date) {
                                setState(() {
                                  dateFin = date;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            FlatButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                    _nameController.text.isEmpty ? _validate = true : _validate = false;
                    _descriptionController.text.isEmpty ? _validate = true : _validate = false;

                  });
                  final event = Event(
                    restaurantId: widget.restauarntId,
                    category: 'happy hour',
                    nom: _nameController.text,
                    description: _descriptionController.text,
                    dateDebut: DateTime.parse(getText(dateDebut)),
                    dateFin: DateTime.parse(getText(dateFin)),
                  );
                  final result = await eventsService.createEvent(event);

                  setState(() {
                    _isLoading = false;
                  });

                  final title = 'Done';
                  final text = 'Your event was created';

                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(title),
                            content: Text(text),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          )).then((data) {
                    if (result.data) {
                      Navigator.of(context).pop();
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: KBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text('Add event',style: TextStyle(
                        fontSize: 20,
                        color: KBackgroundColor,
                        letterSpacing: 2),))))
          ],
        ),
      ),
    );
  }
}
