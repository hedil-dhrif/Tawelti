import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_shapes/flutter_shapes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/screens/Addfloor/FloorDetailsPage.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/DragBox.dart';
import 'package:tawelti/widgets/DraggableTables.dart';
import 'package:tawelti/widgets/navbar2.dart';
import 'package:tawelti/widgets/roundedButton.dart';
import 'package:tawelti/widgets/zone.dart';

class ZonePlanPage extends StatefulWidget {
  @override
  _ZonePlanPageState createState() => _ZonePlanPageState();
}

class _ZonePlanPageState extends State<ZonePlanPage> {
  var isSuccessful = true;
  Widget variable;
  List<Widget> tables;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    tables = <Widget>[
      GestureDetector(
        onDoubleTap: () {
          _deleteDialog();
        },
        onTap: () {
          _showMyDialog();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: KBlue,
          ),
          height: 60,
          width: 60,
        ),
      ),
      GestureDetector(
        onDoubleTap: () {
          _deleteDialog();
        },
        onTap: () {
          _showMyDialog();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: KBlue,
          ),
          height: 60,
          width: 60,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = tables.removeAt(oldIndex);
        tables.insert(newIndex, row);
      });
    }

    var wrap = ReorderableWrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        maxMainAxisCount: 4,
        spacing: 30,
        runSpacing: 24.0,
        padding: const EdgeInsets.all(8),
        children: tables,
        onReorder: _onReorder,
        onNoReorder: (int index) {
          //this callback is optional
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
        },
        onReorderStarted: (int index) {
          //this callback is optional
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
        });
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
            'Floor Plan',
            style: TextStyle(color: Colors.black87, fontSize: 24),
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
      body: Container(
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black87),
                                  ),
                                  hintText: 'Floor',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 100,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black87),
                                  ),
                                  hintText: 'Zone',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 30,
                          ),
                          Icon(
                            Icons.edit_outlined,
                            size: 30,
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 120,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                          ),
                          hintText: 'Waiter name',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: KBeige),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        var newTable = GestureDetector(
                          onDoubleTap: () {
                            _deleteDialog();
                          },
                          onTap: () {
                            _showMyDialog();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: KBlue,
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: 60,
                          ),
                        );
                        setState(() {
                          tables.add(newTable);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: KBlue,
                        ),
                        height: 60,
                        width: 60,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        var newTable = GestureDetector(
                          onDoubleTap: () {
                            _deleteDialog();
                          },
                          onTap: () {
                            _showMyDialog();
                          },
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: KBlue,
                          ),
                        );
                        setState(() {
                          tables.add(newTable);
                        });
                      },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: KBlue,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        var newTable = GestureDetector(
                            onDoubleTap: () {
                              _deleteDialog();
                            },
                            onTap: () {
                              _showMyDialog();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: KBlue,
                              ),
                              height: 60,
                              width: 100,
                            ));
                        setState(() {
                          tables.add(newTable);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: KBlue,
                        ),
                        height: 60,
                        width: 100,
                      ),
                    ),
                    FlatButton(
                        onPressed: () {
                          _showShapesDialog();
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: KBeige),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 32,
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: wrap,
              ),
              margin: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120, top: 20),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FloorDetailsPage(
                                ListTables: tables,
                              )));
                },
                child: Container(
                  height: 60,
                  width: 200,
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
                            'Submit',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    int _counter = 0;

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

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffF4F4F4),
          title: Center(
              child: Text(
            'Table details',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Guests number',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$_counter',
                                style: TextStyle(
                                  fontSize: 24,
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RadioButtonGroup(
                        labels: [
                          'blocked',
                        ],
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        activeColor: KBlue,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reservations',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 32,
                      ),
                    ],
                  ),
                )
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
                          'Submit',
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

  Future<void> _showShapesDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffF4F4F4),
          title: Center(
              child: Text(
            'Add Tables',
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          var newTable = GestureDetector(
                            onDoubleTap: () {
                              _deleteDialog();
                            },
                            onTap: () {
                              _showMyDialog();
                            },
                            child: ClipOval(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: KBlue,
                                ),
                                height: 60,
                                width: 90,
                              ),
                            ),
                          );
                          setState(() {
                            tables.add(newTable);
                            Navigator.pop(context);
                          });
                        },
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              color: KBlue,
                            ),
                            height: 60,
                            width: 90,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var newTable = GestureDetector(
                            onDoubleTap: () {
                              _deleteDialog();
                            },
                            onTap: () {
                              _showMyDialog();
                            },
                            child: ClipPath(
                                clipper: OctagonalClipper(),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  color: KBlue,
                                )),
                          );
                          setState(() {
                            tables.add(newTable);
                            Navigator.pop(context);
                          });
                        },
                        child: ClipPath(
                            clipper: OctagonalClipper(),
                            child: Container(
                              height: 80,
                              width: 80,
                              color: KBlue,
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          var newTable = GestureDetector(
                            onDoubleTap: () {
                              _deleteDialog();
                            },
                            onTap: () {
                              _showMyDialog();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: KBlue,
                              ),
                              height: 100,
                              width: 60,
                            ),
                          );
                          setState(() {
                            tables.add(newTable);
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: KBlue,
                          ),
                          height: 100,
                          width: 60,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var newTable = GestureDetector(
                            onDoubleTap: () {
                              _deleteDialog();
                            },
                            onTap: () {
                              _showMyDialog();
                            },
                            child: ClipOval(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: KBlue,
                                ),
                                height: 100,
                                width: 70,
                              ),
                            ),
                          );
                          setState(() {
                            tables.add(newTable);
                            Navigator.pop(context);
                          });
                        },
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              color: KBlue,
                            ),
                            height: 100,
                            width: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffF4F4F4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Are you sure you want to remove this table',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      ),
                      Container(
                        width: 10,
                        color: Colors.grey,
                      ),
                      TextButton(
                        child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                        ),
                        onPressed: () {
                          setState(() {
                            tables.removeAt(0);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
