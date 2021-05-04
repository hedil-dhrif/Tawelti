import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/screens/Addfloor/floorPlan.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:reorderables/reorderables.dart';

class FloorDetailsPage extends StatefulWidget {
  List ListTables;
  FloorDetailsPage({this.ListTables});
  @override
  _FloorDetailsPageState createState() => _FloorDetailsPageState();
}

class _FloorDetailsPageState extends State<FloorDetailsPage> {
  int acceptedData = 0;
  var item;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
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
                          hintText: 'floor name',
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
            SizedBox(height: 10,),
            Container(
              color: KBlue,
              child: FloorPlan(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KBlue,
        child: Icon(Icons.add),
        onPressed:(){
          _ajouterZone();
        },
      ),
    );
  }
  _ajouterZone(){
    return Container();
  }
}
