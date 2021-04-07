import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/floorPlan.dart';
import 'package:reorderables/reorderables.dart';

class FloorDetailsPage extends StatefulWidget {
  @override
  _FloorDetailsPageState createState() => _FloorDetailsPageState();
}

class _FloorDetailsPageState extends State<FloorDetailsPage> {
  int acceptedData = 0;
  var item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: KBlue,
        ),
        title: AppBarWidget(
          title: 'Floor Plan',
          icon: Icons.close,
          onpressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        hintText: 'Zone number',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: 24,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.edit_outlined,
                      size: 24,
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 120, left: 20, right: 20),
            color: KBlue,
            child: ReorderableWrap(
              children: [
                FloorPlan(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
