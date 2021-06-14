import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/table.dart';
import 'package:tawelti/models/waiter.dart';
import 'package:tawelti/models/zone.dart';
import 'package:tawelti/screens/Addfloor/roundedTable.dart';
import 'package:tawelti/screens/Addfloor/tableDetails.dart';
import 'package:tawelti/screens/Addfloor/tableITem2.dart';
import 'package:tawelti/screens/Addfloor/tableItem.dart';
import 'package:tawelti/services/table.services.dart';
import 'package:tawelti/services/waiter.services.dart';
import 'package:tawelti/services/zone.services.dart';
import 'package:tawelti/widgets/floorDelete.dart';

class ZonePlanPage extends StatefulWidget {
  final int etageId;
  final int zoneId;
  final int restaurantId;
  ZonePlanPage({Key key, this.zoneId,this.etageId,this.restaurantId}) : super(key: key);
  @override
  _ZonePlanPageState createState() => _ZonePlanPageState();
}

class _ZonePlanPageState extends State<ZonePlanPage> {
  TableServices get tableService => GetIt.I<TableServices>();
  ZoneServices get zoneService => GetIt.I<ZoneServices>();
  WaiterServices get waiterService => GetIt.I<WaiterServices>();
  List<Waiter> waiters = [];
  APIResponse<List<Waiter>> _apiResponse;
  APIResponse<List<RestaurantTable>> _apiResponseTables;

  var isSuccessful = true;
  //Widget variable;
  bool _enabled = false;
  final List<String> listWaiters = [];
  bool _isLoading = false;
  Size size;
  Offset position;
  String dropdownValue;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool get isEditing => widget.zoneId != null;
  String errorMessage;
  Zone zone;
  Waiter waiter;
  UniqueKey key;
  TextEditingController zoneNameController = TextEditingController();
  TextEditingController waiterNameController;

  //var keyText = GlobalKey();

  @override
  void initState() {
    if (isEditing) {
      _getZoneDetails();
      _fetchTables(widget.zoneId);
      _fetchWaiters();
    }
    super.initState();
    calculateSizeAndPosition(key);
  }

  void calculateSizeAndPosition(key) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox box = key.context.findRenderObject();

        setState(() {
          position = box.localToGlobal(Offset.zero);
        });
        print(position.dx);
        print(position.dy);
      });

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _buildListTables().removeAt(oldIndex);
        _buildListTables().insert(newIndex, row);
      });
    }

    final wrap = _isLoading?CircularProgressIndicator():ReorderableWrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        maxMainAxisCount: 4,
        spacing: 20,
        runSpacing: 16.0,
        padding: const EdgeInsets.all(8),
        children: _buildListTables(),
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
            'Zone Details',
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
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextFormField(
                              enabled: _enabled,
                              controller: zoneNameController,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Outside Zone',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                final result = await showDialog(
                                    context: context,
                                    builder: (_) => FloorDelete());

                                if (result) {
                                  final deleteResult = await zoneService
                                      .deleteZone(widget.zoneId.toString());
                                  Navigator.of(context).pop();
                                  var message =
                                      'The zone was deleted successfully';

                                  // showDialog(
                                  //     context: context,
                                  //     builder: (_) => AlertDialog(
                                  //           title: Text('Done'),
                                  //           content: Text(message),
                                  //           actions: <Widget>[
                                  //             FlatButton(
                                  //                 child: Text('Ok'),
                                  //                 onPressed: () {
                                  //                   Navigator.of(context).pop();
                                  //                 })
                                  //           ],
                                  //         ));

                                  return deleteResult?.data ?? false;
                                }
                                print(result);
                                return result;
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _enabled = !_enabled;
                                });
                              },
                              icon: Icon(
                                Icons.edit_outlined,
                                size: 30,
                              ))
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Waiter name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: KBlue,
                        ),
                      ),
                      Container(
                        width: 150,
                        child:_builListWaiters(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'List tables',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
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
                        setState(() {
                          _addTable(100, 2, 1, 0);
                          _fetchTables(widget.zoneId);

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
                        setState(() {
                          _addTable(101, 4, 1, 0);
                          _fetchTables(widget.zoneId);

                        });
                      },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: KBlue,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _addTable(102, 4, 2, 0);
                          _fetchTables(widget.zoneId);
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
                //child: _buildListTables(_apiResponseTables.data),
                child: _isLoading?CircularProgressIndicator():wrap,
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
              padding: const EdgeInsets.only(left: 120, top: 20, right: 20),
              child: GestureDetector(
                onTap: ()  {
                  _enabled?_updateZone():Navigator.pop(context);
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
                            style:
                                TextStyle(fontSize: 24, color: Colors.white),
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
                      ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            color: KBlue,
                          ),
                          height: 60,
                          width: 90,
                        ),
                      ),
                      ClipPath(
                          clipper: OctagonalClipper(),
                          child: Container(
                            height: 80,
                            width: 80,
                            color: KBlue,
                          )),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: KBlue,
                        ),
                        height: 100,
                        width: 60,
                      ),
                      ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            color: KBlue,
                          ),
                          height: 100,
                          width: 70,
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

  _builListWaiters() {
    return _isLoading?CircularProgressIndicator():DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(CupertinoIcons.chevron_down),
      iconSize: 24,
      //elevation: 50,
      style: const TextStyle(color: Colors.black87),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: _buildListWaiters().map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }

  _getZoneDetails() async {
    setState(() {
      _isLoading = true;
    });
    await zoneService.getZone(widget.zoneId.toString()).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      zone = response.data;
      print(zone.nom);
      print(zone.id);
      zoneNameController.text = zone.nom;
      //_contentController.text = note.noteContent;
    });
    setState(() {
      _isLoading = false;
    });
  }
// _getWaiterName()async{
//   setState(() {
//     _isLoading = true;
//   });
//   await zoneService.getZoneWaiter(widget.zoneId.toString()).then((response) {
//     if (response.error) {
//       errorMessage = response.errorMessage ?? 'An error occurred';
//     }
//     waiter = response.data;
//     print(waiter.id);
//     dropdownValue=waiter.nom;
//     //_contentController.text = note.noteContent;
//   });
//   setState(() {
//     _isLoading = false;
//   });
// }

  _fetchWaiters() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await waiterService.getWaitersList(widget.restaurantId.toString());
    setState(() {
      _isLoading = false;
    });
  }

  _buildListWaiters() {
    for (int i = 0; i < _apiResponse.data.length; i++) {
      listWaiters.add(_apiResponse.data[i].prenom);
    }
    return listWaiters;
  }

  _fetchTables(zoneID) async {
    print(zoneID);
    setState(() {
      _isLoading = true;
    });

    _apiResponseTables = await zoneService.getZoneTablesList(zoneID.toString());
    print(_apiResponseTables.data.length);

    setState(() {
      _isLoading = false;
    });
  }

  List<Widget> _buildListTables() {
    final List<Widget> tables = [];
    for (int i = 0; i < _apiResponseTables.data.length; i++) {
      var code = _apiResponseTables.data[i].code;
      Widget getTable() {
        switch (code) {
          case 100:
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsTable(
                                tableCode: _apiResponseTables.data[i].code,
                                zoneId: widget.zoneId,
                                tableId:
                                    _apiResponseTables.data[i].id.toString(),
                              ))).then((__) => _fetchTables(widget.zoneId));
                },
                child: TableItem(
                  index: _apiResponseTables.data[i].id.toString(),
                  etat: _apiResponseTables.data[i].etat,
                  deleteFunction: () async {
                    final deleteResult = await tableService
                        .deleteTable(_apiResponseTables.data[i].id.toString());
                    _fetchTables(widget.zoneId);

                    var message = 'The table was deleted successfully';

                    return deleteResult?.data ?? false;
                  },
                ));

            break;
          case 101:
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsTable(
                                tableCode: _apiResponseTables.data[i].code,
                                zoneId: widget.zoneId,
                                tableId:
                                    _apiResponseTables.data[i].id.toString(),
                              ))).then((__) => _fetchTables(widget.zoneId));
                },
                child: RoundedTable(
                  index: _apiResponseTables.data[i].id.toString(),
                  etat: _apiResponseTables.data[i].etat,
                  deleteFunction: () async {
                    final deleteResult = await tableService
                        .deleteTable(_apiResponseTables.data[i].id.toString());
                    _fetchTables(widget.zoneId);

                    var message = 'The table was deleted successfully';

                    return deleteResult?.data ?? false;
                  },
                ));
            break;
          case 102:
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsTable(
                                tableCode: _apiResponseTables.data[i].code,
                                zoneId: widget.zoneId,
                                tableId:
                                    _apiResponseTables.data[i].id.toString(),
                              ))).then((__) => _fetchTables(widget.zoneId));
                },
                child: TableItem2(
                  index: _apiResponseTables.data[i].id.toString(),
                  etat: _apiResponseTables.data[i].etat,
                  deleteFunction: () async {
                    final deleteResult = await tableService
                        .deleteTable(_apiResponseTables.data[i].id.toString());
                    _fetchTables(widget.zoneId);

                    var message = 'The table was deleted successfully';

                    return deleteResult?.data ?? false;
                  },
                ));
            break;
        }
      }

      tables.add(getTable());
    }
    return tables;
  }

  _addTable(code, nbCouverts, tolerance, etat) async {
    setState(() {
      _isLoading = true;
    });
    final table = RestaurantTable(
      code: code,
      nbCouverts: nbCouverts,
      tolerance: tolerance,
      etat: etat,
      zoneId: widget.zoneId,
    );
    final result = await tableService.createTable(table);

    setState(() {
      _isLoading = false;
    });

    // showDialog(
    //     context: context,
    //     builder: (_) => AlertDialog(
    //           title: Text('Done'),
    //           content: Text('your table is added successfully'),
    //           actions: <Widget>[
    //             FlatButton(
    //               child: Text('Ok'),
    //               onPressed: () {
    //                 setState(() {
    //                   Navigator.pop(context);
    //                 });
    //               },
    //             )
    //           ],
    //         ));
  }

  _updateZone()async{
    setState(() {
      _isLoading = true;
    });
    final zone = Zone(
      etageId: widget.etageId,
      nom: zoneNameController.text,
    );
    final result = await zoneService.updateZone(
        widget.zoneId.toString(), zone);
    setState(() {
      _isLoading = false;
    });

    final title = 'Done';
    final text = 'Your zone was updated';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => FloorDetailsPage()));

  }
}
