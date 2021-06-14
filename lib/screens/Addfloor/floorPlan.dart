import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/table.dart';
import 'package:tawelti/models/zone.dart';
import 'package:tawelti/screens/Addfloor/roundedTable.dart';
import 'package:tawelti/screens/Addfloor/tableITem2.dart';
import 'package:tawelti/screens/Addfloor/tableItem.dart';
import 'package:tawelti/screens/Addfloor/zoneItem.dart';
import 'package:tawelti/screens/Addfloor/zonePlan.dart';
import 'package:tawelti/services/zone.services.dart';

class FloorPlan extends StatefulWidget {
  final int restaurantId;
  final int etageID;
  FloorPlan({this.etageID, this.restaurantId});
  @override
  _FloorPlanState createState() => _FloorPlanState();
}

class _FloorPlanState extends State<FloorPlan> {
  bool _isLoading = false;
  ZoneServices get zoneService => GetIt.I<ZoneServices>();
  List<Zone> zones = [];
  APIResponse<List<Zone>> _apiResponse;
  final List<String> listZonesId = [];

  void initState() {
    _fetchFloors();
    super.initState();
  }

  _fetchFloors() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await zoneService.getZonesList(widget.etageID.toString());
    _buildListZonesId();
    setState(() {
      _isLoading = false;
    });
  }

  // List<Widget> ListTables=widget.ListTables;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.9,
      color: KBlue,
      child: _isLoading
          ? CircularProgressIndicator()
          : _buildListZones(_apiResponse.data),
    );
  }

  _buildListZones(List data) {
    return Container(
      child: new StaggeredGridView.countBuilder(
        crossAxisCount: 1,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ZonePlanPage(
                          zoneId: data[index].id,
                          etageId: data[index].etageId,
                          restaurantId: widget.restaurantId,
                        ))).then((__) => _fetchFloors());
          },
          child: ZoneItem(
            zoneId: data[index].id,
            zoneName: data[index].nom,
          ),
        ),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 1 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  _buildListZonesId() {
    for (int i = 0; i < _apiResponse.data.length; i++) {
      listZonesId.add(_apiResponse.data[i].id.toString());
      print(listZonesId[i]);
    }
    return listZonesId;
  }
}
