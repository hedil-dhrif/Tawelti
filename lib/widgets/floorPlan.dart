import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tawelti/screens/Addfloor/zonePlan.dart';


class FloorPlan extends StatefulWidget {


  @override
  _FloorPlanState createState() => _FloorPlanState();
}

class _FloorPlanState extends State<FloorPlan> {
  List imageList = ['1','2','3'];

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = imageList.removeAt(oldIndex);
      imageList.insert(newIndex, row);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableWrap(
      spacing: 8.0,
      runSpacing: 4.0,
      onReorder: _onReorder,
      padding: const EdgeInsets.all(8),
      children:[ Container(
        height: MediaQuery.of(context).size.height*0.75,
        width: MediaQuery.of(context).size.width*0.9,
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ZonePlanPage()));
            },
            child: new Container(
                color: Colors.green,
                child: new Center(
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: new Text('$index'),
                  ),
                )),
          ),
          staggeredTileBuilder: (index) => StaggeredTile.count(
              (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    ],
    );
  }
}






