import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/DragBox.dart';
import 'package:tawelti/widgets/DraggableTables.dart';
import 'package:tawelti/widgets/navbar2.dart';
import 'package:tawelti/widgets/roundedButton.dart';

class ZonePlanPage extends StatefulWidget {
  @override
  _ZonePlanPageState createState() => _ZonePlanPageState();
}

class _ZonePlanPageState extends State<ZonePlanPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AppBarWidget(
          title: 'Add to wait list',
          icon: Icons.close,
          onpressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: BottomNavBarV2(bgColor: KBlue,
        activeIconColor: Colors.white,
        deactiveIconColor: Colors.grey[300],
        syncButton: RoundedButton(
          radius: 60,
          color: KBeige,
          // press: () => Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => StatsPage())),
          icon:   SvgPicture.asset(
            'assets/plus.svg',
            color: Colors.white,
            height:32,
            width: 32,
          ),
        ),),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 60,left: 20,right: 20),
                    child:   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child:   TextFormField(

                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black87),
                                        ),
                                        hintText:'Floor' ,
                                        hintStyle: TextStyle(fontSize: 20, color: Colors.black,)

                                    ),

                                  ),

                                ),
                                SizedBox(width: 20,),
                                Container(
                                  width: 100,
                                  child:   TextFormField(

                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black87),
                                        ),
                                        hintText:'Zone' ,
                                        hintStyle: TextStyle(fontSize: 20, color: Colors.black,)

                                    ),

                                  ),

                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.delete_outline,size: 30,),
                                Icon(Icons.edit_outlined,size: 30,)
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: 120,
                          child:   TextFormField(

                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                ),
                                hintText:'Waiter name' ,
                                hintStyle: TextStyle(fontSize: 20, color: Colors.black54,)

                            ),

                          ),

                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: KBeige),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.only(top:20,left: 20,right: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DragBox(Offset(0.0, 0.0), 'Box One', Colors.blueAccent),
                          DragBox(Offset(200.0, 0.0), 'Box Two', Colors.orange),
                          DragBox(Offset(300.0, 0.0), 'Box Three', Colors.lightGreen),

                          FlatButton( child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: KBeige),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(Icons.add),
                          ))
                        ],
                      ),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(top:20,left: 20,right: 20,),
                    height: MediaQuery.of(context).size.height *0.6,
                    width: MediaQuery.of(context).size.width *0.9,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
