import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/floor.dart';
import 'package:tawelti/models/zone.dart';
import 'package:tawelti/screens/Addfloor/floorPlan.dart';
import 'package:tawelti/services/floor.services.dart';
import 'package:tawelti/services/zone.services.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:reorderables/reorderables.dart';

class FloorDetailsPage extends StatefulWidget {
  final int etageID;
  FloorDetailsPage({this.etageID});
  @override
  _FloorDetailsPageState createState() => _FloorDetailsPageState();
}

class _FloorDetailsPageState extends State<FloorDetailsPage> {
  bool get isEditing => widget.etageID != null;

  FloorServices get floorsService => GetIt.I<FloorServices>();
  ZoneServices get zoneService => GetIt.I<ZoneServices>();
  List<Zone> zones = [];
  APIResponse<List<Zone>> _apiResponse;
  String errorMessage;
  Floor floor;
  int acceptedData = 0;
  int restaurantId;
  var item;
  bool _isLoading = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController zoneNameController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      floorsService.getFloor(widget.etageID.toString()).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        floor = response.data;
        print(floor);
        _titleController.text = floor.nom;
        restaurantId=floor.RestaurantId;
        //_contentController.text = note.noteContent;
      });
    }

    super.initState();
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
            'Floor Details',
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
      body: _isLoading?CircularProgressIndicator():SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: TextFormField(
                        enabled: true,
                        controller: _titleController,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'floor name',
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Row(
                      children: [
                        FlatButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            final floor = Floor(
                              nom: _titleController.text,
                              //noteContent: _contentController.text
                            );
                            final result = await floorsService.updateFloor(
                                widget.etageID.toString(), floor);
                            setState(() {
                              _isLoading = false;
                            });

                            final title = 'Done';
                            final text = 'Your floor was updated';

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
                                    ));
                          },
                          child: Icon(
                            Icons.edit_outlined,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'List Zones',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Container(
                    //color: KBlue,
                    child: _isLoading?CircularProgressIndicator():FloorPlan(etageID: widget.etageID,restaurantId: restaurantId,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KBlue,
        child: Icon(Icons.add),
        onPressed: () {
          _showMyDialog().then((__) => _fetchZones());
        },
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
                'Add new Zone',
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
                    controller: zoneNameController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        labelText: 'Zone Name',
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
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                final zone = Zone(
                  etageId: widget.etageID,
                  nom: zoneNameController.text,
                );
                final result = await zoneService.createZone(zone).then((__) => _fetchZones());

                setState(() {
                  _isLoading = false;
                });

                Navigator.of(context).pop();

                final title = 'Done';
                final text = 'Your zone was created';

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
                    ));
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
                          'Add zone',
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

  _fetchZones() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await zoneService.getZonesList(widget.etageID.toString());

    setState(() {
      _isLoading = false;
    });
  }

}
