import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/models/table.dart';
import 'package:tawelti/screens/Addfloor/roundedTable.dart';
import 'package:tawelti/screens/Addfloor/tableITem2.dart';
import 'package:tawelti/screens/Addfloor/tableItem.dart';
import 'package:tawelti/services/zone.services.dart';

class ZoneItem extends StatefulWidget {
 final int zoneId;
 final String zoneName;
 ZoneItem({this.zoneId,this.zoneName});
  @override
  _ZoneItemState createState() => _ZoneItemState();
}

class _ZoneItemState extends State<ZoneItem> {
  ZoneServices get zoneService => GetIt.I<ZoneServices>();
  APIResponse<List<RestaurantTable>> _apiResponseTables;

  //List<Table> tables = [];
  //FloorServices get floorService => GetIt.I<FloorServices>();
  //APIResponse<List<Floor>> _apiResponse;

  bool _isLoading = false;

  // void _onReorder(int oldIndex, int newIndex) {
  //   setState(() {
  //     Widget row = widget.tables.removeAt(oldIndex);
  //     widget.tables.insert(newIndex, row);
  //   });
  // }

  @override
  void initState() {
    _fetchTables();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.grey[300],
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(widget.zoneName),
            FittedBox(
              fit: BoxFit.contain,
              child: _isLoading?CircularProgressIndicator():ReorderableWrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  maxMainAxisCount: 3,
                  // spacing: 30,
                  // runSpacing: 24.0,
                  padding: const EdgeInsets.all(8),
                  children: _buildListTables(widget.zoneId),
                  onNoReorder: (int index) {
                    //this callback is optional
                    debugPrint(
                        '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                  },
                  onReorderStarted: (int index) {
                    //this callback is optional
                    debugPrint(
                        '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
                  }),
            ),
          ],
        ));
  }

  _fetchTables() async {
      setState(() {
        _isLoading = true;
      });

      _apiResponseTables = await zoneService.getZoneTablesList(widget.zoneId.toString());
      print(_apiResponseTables.data);
      setState(() {
        _isLoading = false;
      });
  }

  List<Widget> _buildListTables(zoneID) {
    final List<Widget> tables = [];
    for (int i = 0; i < _apiResponseTables.data.length; i++) {
      var code = _apiResponseTables.data[i].code;
      Widget getTable() {
        switch (code) {
          case 100:
            return TableItem(
              index: _apiResponseTables.data[i].id.toString(),
              etat: _apiResponseTables.data[i].etat,
            );

            break;
          case 101:
            return RoundedTable(
              index: _apiResponseTables.data[i].id.toString(),
              etat: _apiResponseTables.data[i].etat,
            );
            break;
          case 102:
            return TableItem2(
              index: _apiResponseTables.data[i].id.toString(),
              etat: _apiResponseTables.data[i].etat,
            );
            break;
        }
      }

      tables.add(getTable());
    }
    return tables;
  }
}
