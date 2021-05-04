import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/screens/Addfloor/zonePlan.dart';

class FloorPlan extends StatefulWidget {
   List<Widget> ListTables;
   FloorPlan({this.ListTables});
  @override
  _FloorPlanState createState() => _FloorPlanState();
}

class _FloorPlanState extends State<FloorPlan> {
  List<Widget> ListTables = [
    Container(
    height: 50,
    width: 50,
    color: KBlue,
  ),
    Container(
      height: 50,
      width: 50,
      color: KBlue,
    ),
    Container(
      height: 50,
      width: 50,
      color: KBlue,
    ),
    Container(
      height: 50,
      width: 50,
      color: KBlue,
    ),
    Container(
      height: 50,
      width: 50,
      color: KBlue,
    ),
    Container(
      height: 50,
      width: 50,
      color: KBlue,
    ),
    Container(
      height: 50,
      width: 50,
      color: KBlue,
    ),
  ];

  // List<Widget> ListTables=widget.ListTables;
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = ListTables.removeAt(oldIndex);
      ListTables.insert(newIndex, row);
    });
  }

  //
  // void _onReorder(int oldIndex, int newIndex) {
  //   setState(() {
  //     Widget row = imageList.removeAt(oldIndex);
  //     imageList.insert(newIndex, row);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var wrap = ReorderableWrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        maxMainAxisCount: 2,
        spacing: 30,
        runSpacing: 24.0,
        padding: const EdgeInsets.all(8),
        children: ListTables,
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
    return Container(
      // height: MediaQuery.of(context).size.height * 0.7,
      // width: MediaQuery.of(context).size.width * 0.9,
      color: KBlue,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          //onReorder: _onReorder,
          //padding: const EdgeInsets.all(8),
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ZonePlanPage()));
              },
              child: Container(
               // height: 400,
               // width: 400,
               color: Color(0xfff6f6f6),
               child: wrap,
                ),
            ),
             Container(
               // height: 400,
               // width: 400,
               color: Colors.grey,
               child: wrap,
             ),
             Container(
               // height: 400,
               // width: 400,
               color: Colors.red,
               child: wrap,
             ),
          ],
        ),
      ),
    );
  }
}
