import 'package:flutter/material.dart';

import '../constants.dart';
import 'DragBox.dart';

class DragTables extends StatefulWidget {
  @override
  _DragTablesState createState() => _DragTablesState();
}

class _DragTablesState extends State<DragTables> {
  Color caughtColor = Colors.grey;

  Widget _duplicate(Widget widget){
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [

          Positioned(
            left: 100.0,
            bottom: 0.0,
            child: DragTarget(
              onAccept: (Color color) {
                caughtColor = color;
              },
              builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                  ) {
                return Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                  ),
                  child: Center(
                    child: Text("Drag Here!"),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
