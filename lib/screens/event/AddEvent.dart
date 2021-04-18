import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tawelti/widgets/CustomInputBox.dart';
import 'package:tawelti/widgets/InputText.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: KBlue,
        ),
        title: AppBarWidget(
          title: 'Add event',
          icon: Icons.close,
          onpressed: () {},
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
          ],
        ),
      ),
    );
  }
}
