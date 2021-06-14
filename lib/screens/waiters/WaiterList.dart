import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/waiter.dart';
import 'package:tawelti/screens/Addfloor/test.dart';
import 'package:tawelti/screens/waiters/DetailWaiter.dart';
import 'package:tawelti/screens/waiters/addWaiter.dart';
import 'package:tawelti/services/waiter.services.dart';
import 'package:tawelti/widgets/WaiterCard.dart';
import 'package:tawelti/widgets/floorDelete.dart';

class WaiterList extends StatefulWidget {
  final int restaurantID;
  WaiterList({this.restaurantID});
  @override
  _WaiterListState createState() => _WaiterListState();
}

class _WaiterListState extends State<WaiterList> {
  WaiterServices get waiterService => GetIt.I<WaiterServices>();
  List<Waiter> waiters = [];
  APIResponse<List<Waiter>> _apiResponse;

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  bool _isLoading = false;

  _fetchWaiters() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await waiterService.getWaitersList(widget.restaurantID.toString());

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchWaiters();
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBlue,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Test()));
            },
            icon: Icon(
              CupertinoIcons.arrow_left,
            ),
          ),
          title: Center(
            child: Text(
              'Waiter list',
              style: TextStyle(
                  fontSize: 25,
                  color: KBlue,
                  fontFamily: 'ProductSans',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w100),
            ),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: _isLoading?CircularProgressIndicator(): _buildWaitersList(_apiResponse.data)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KBeige,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddWaiter(restaurantID:33,))).then((__) => _fetchWaiters())
              .then((__) => _fetchWaiters());
        },
      ),
    );
  }

  _buildWaitersList(List data) {
    return Container(
      child:ListView.separated(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(data[index].id),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {},
            confirmDismiss: (direction) async {
              final result = await showDialog(
                  context: context, builder: (_) => FloorDelete());

              if (result) {
                final deleteResult = await waiterService
                    .deleteWaiter(data[index].id.toString());
                _fetchWaiters();

                var message = 'The waiter was deleted successfully';

                return deleteResult?.data ?? false;
              }
              print(result);
              return result;
            },
            child: WaiterCard(
              waiterId: data[index].id,
              firstname: data[index].nom,
              lastname: data[index].prenom,
              phoneNumber: data[index].telephone,
              zone: data[index].adresse,
              pressDetails:  () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => DetailWaiter(waiterId: data[index].id,)))
              .then((__) => _fetchWaiters());
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.black87,
        ),
      ),
    );
  }
}
