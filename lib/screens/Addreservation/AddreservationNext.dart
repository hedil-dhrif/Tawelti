import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/screens/Addreservation/AddResrvationDetails.dart';
import 'package:tawelti/screens/HomePage.dart';

class AddReservationNext extends StatefulWidget {
  @override
  _AddReservationNextState createState() => _AddReservationNextState();
}

class _AddReservationNextState extends State<AddReservationNext> {
  //int _index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: KBlue, size: 30),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Add Reservation',
              style: TextStyle(
                  fontSize: 25,
                  color: KBlue,
                  fontFamily: 'ProductSans',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w100),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: KBlue,
                ),
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.menu,
                  color: KBeige,
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.grid_view,
                  color: KBeige,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    MyStatefulWidget(),
                    SizedBox(height: 20,),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddReservationDetails()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: KBeige,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

class Item {
  Item({
    @required this.expandedValue,
    @required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Table $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          backgroundColor: KBlue,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Center(
                child: Text(
                  item.headerValue,
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, letterSpacing: 1),
                ),
              ),
            );
          },
          body: ListTile(
            title: Center(
              child: Text(
                item.expandedValue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
