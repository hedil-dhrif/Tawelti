import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/ListHeaders.dart';
import 'package:tawelti/widgets/list.dart';

import '../../constants.dart';

class AddFloorPage extends StatefulWidget {
  @override
  _AddFloorPageState createState() => _AddFloorPageState();
}

class _AddFloorPageState extends State<AddFloorPage> {
  final FloorNameController = TextEditingController();
  final ZoneNumberController = TextEditingController();
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    FloorNameController.dispose();
    super.dispose();
  }

  @override
  void dispose1() {
    // Clean up the controller when the widget is disposed.
    ZoneNumberController.dispose();
    super.dispose();
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
          title: 'Add floor plan',
          icon: Icons.close,
          onpressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Floor Plan \n',
                  style: TextStyle(
                    fontSize: 25,
                    color: KBlue,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add new Floor',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showMyDialog();
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.add,
                          color: KBeige,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: KBeige),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListHeaders(),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 220, left: 20, right: 20),
              child: listFloor()),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffF4F4F4),
          title: Center(
              child: Text(
            'Add Floor Plan',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          )),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: TextFormField(
                    controller: FloorNameController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        labelText: 'Floor Name',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: TextFormField(
                    controller: ZoneNumberController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        labelText: 'Zone number',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 40,
                width: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: KBlue,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Add floor',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
