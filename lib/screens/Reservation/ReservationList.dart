import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/Restaurant.dart';
import 'package:tawelti/models/reservation.dart';
import 'package:tawelti/screens/Reservation/AddReservation.dart';
import 'package:tawelti/screens/Reservation/DetailsReservation.dart';
import 'package:tawelti/services/reservation.services.dart';
import 'package:tawelti/services/user.services.dart';
import 'package:tawelti/widgets/RestauCard.dart';
import 'package:tawelti/widgets/floorDelete.dart';

class ReservationtList extends StatefulWidget {
  @override
  _ReservationtListState createState() => _ReservationtListState();
}

class _ReservationtListState extends State<ReservationtList> {
  ReservationServices get reservationService => GetIt.I<ReservationServices>();
  UserServices get userService => GetIt.I<UserServices>();

  List<Reservation> reservations = [];
  APIResponse<List<Reservation>> _apiResponse;
  bool _isLoading = false;
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  String errorMessage;

  @override
  void initState() {
    _getUserInfo();
    //_fetchReservations();
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  TextEditingController NameController = TextEditingController();
  bool _isEnabled = false;
  var user;
  int Id;
  Restaurant restaurant;

  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var userId = localStorage1.getInt('id');
    print(userId);
    setState(() {
      user = userId;
      _getUserRestaurant(user);
      print(user);
    });
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
            'Reservation list',
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
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              height: MediaQuery.of(context).size.height * 0.6,
              child: _isLoading?CircularProgressIndicator():_buildEventsList(_apiResponse.data),
            ),

            /*..._selectedEvents.map(
              (event) => ListTile(
                title: Container(
                  color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Text(event.title),
                ),
                */ /*onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventDetailsPage(
                        event: event,
                      ),
                    ),
                  );
                },*/ /*
              ),
            ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KBeige,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddReservation(
                        restaurantId: restaurant.id,
                      ))).then((__) => _fetchReservations());
        },
      ),
    );
  }

  _fetchReservations() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse =
        await reservationService.getReservationsList(restaurant.id.toString());
    print(_apiResponse.data.length);
    setState(() {
      _isLoading = false;
    });
  }

  _buildEventsList(List data) {
    if (data.length > 0) {
      return Container(
        child: ListView.separated(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            if (data[index].etat == 1) {
              return Dismissible(
                key: ValueKey(data[index].id),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context, builder: (_) => FloorDelete());

                  if (result) {
                    final deleteResult = await reservationService
                        .deleteReservation(data[index].id.toString());
                    _fetchReservations();

                    var message = 'The reservation was deleted successfully';

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
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailReservation(
                                  reservationId: data[index].id,
                                ))).then((__) => _fetchReservations());
                  },
                  child: RestauCard(
                    guestname: data[index].nomPersonne,
                    nbPersonne: data[index].nbPersonne.toString(),
                    reservationId: data[index].id,
                    reservationDate: data[index].dateReservation,
                    reservationTime: data[index].heureReservation,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black87,
          ),
        ),
      );
    } else {
      return Center(
          child: Text(
        'no reservations yet',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ));
    }
  }

  _getUserRestaurant(userId) async {
    setState(() {
      _isLoading = true;
    });
    await userService.getUserRestauarnt(userId.toString()).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      restaurant = response.data;
      _fetchReservations();
      print(restaurant.id);
      print(restaurant.NomResto);
      print(restaurant.id);
      print(restaurant.adresse);
      print(restaurant.Description);
      setState(() {
        _isLoading = false;
      });

      // _titleController.text = floor.nom;
      //_contentController.text = note.noteContent;
    });
  }
}
