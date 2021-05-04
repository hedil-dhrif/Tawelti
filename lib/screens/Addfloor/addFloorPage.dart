import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/ListHeaders.dart';
import 'package:tawelti/widgets/floorItem.dart';
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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
          leading:Icon(CupertinoIcons.arrow_left),
          title: Text('Floor Plan',          style: TextStyle(color: Colors.black87, fontSize: 24),
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            ListHeaders(),
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: _buildFloorList()),
          ],
        ),
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
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 60,
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
                          style: TextStyle(fontSize: 20, color: Colors.white),
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

  _buildFloorList() {
    return Container(
      child: ListView.separated(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return FloorItem(floorname: 'ghj', zoneNumber: '3', tableNumber: 0);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.black87,
        ),
      ),
    );
  }
}

