import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/event.dart';
import 'package:tawelti/models/waiter.dart';
import 'package:tawelti/screens/event/AddEvent.dart';
import 'package:tawelti/screens/event/DetailsEvent.dart';
import 'package:tawelti/services/event.services.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/EventCard.dart';
import 'package:tawelti/widgets/floorDelete.dart';

class EventList extends StatefulWidget {
  final int restaurantId;
  EventList({this.restaurantId});
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  EventServices get eventService => GetIt.I<EventServices>();
  List<Event> events = [];
  APIResponse<List<Event>> _apiResponse;
  bool _isLoading = false;

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  _fetchEvents() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await eventService.getEventsList(widget.restaurantId.toString());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchEvents();
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
          leading: Icon(CupertinoIcons.arrow_left),
          title: Text(
            'Event list',
            style: TextStyle(
                fontSize: 25,
                color: KBlue,
                fontFamily: 'ProductSans',
                letterSpacing: 1,
                fontWeight: FontWeight.w100),
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
            Container(
              color: Colors.white,
              child: TableCalendar(
                events: _events,
                initialCalendarFormat: CalendarFormat.week,
                calendarStyle: CalendarStyle(
                  selectedColor: KBlue,
                  todayColor: KBeige,
                  weekendStyle: TextStyle(color: KBeige),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: KBlue,
                    fontSize: 15,
                  ),
                  weekendStyle: TextStyle(color: KBeige),
                ),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonShowsNext: false,
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events, _) {
                  setState(() {
                    _selectedEvents = events;
                  });
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: KBlue,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                calendarController: _controller,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: _buildEventsList(_apiResponse.data)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KBeige,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEvent(restauarntId: widget.restaurantId,))).then((__) => _fetchEvents());
        },
      ),
    );
  }

  _buildEventsList(List data) {
    if(data.length>0){
      return Container(
        child: ListView.separated(
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
                  final deleteResult = await eventService
                      .deleteEvent(data[index].id.toString());
                  _fetchEvents();

                  var message = 'The event was deleted successfully';

                  return deleteResult?.data ?? false;
                }
                print(result);
                return result;
              },
              background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerLeft,
                  )),
              child: EventCard(
                EventName: data[index].nom,
                category: data[index].category,
                description: data[index].description,
                pressDetails:  () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => DetailsEvent(eventId: data[index].id,))).then((__) => _fetchEvents());
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black87,
          ),
        ),
      );
    }else{
      return Center(child: Text('no events yet',style: TextStyle(fontSize: 20,color: Colors.white),));

    }

  }
}
