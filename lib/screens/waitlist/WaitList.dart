import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/reservation.dart';
import 'package:tawelti/screens/Reservation/DetailsReservation.dart';
import 'package:tawelti/screens/Reservation/ReservationList.dart';
import 'package:tawelti/services/reservation.services.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/CustomCard.dart';
import 'package:tawelti/widgets/RestauCard.dart';
import 'package:tawelti/widgets/floorDelete.dart';
import 'package:tawelti/widgets/waitCard.dart';

class WaitList extends StatefulWidget {
  final int restaurantID;
  WaitList({this.restaurantID});
  @override
  _WaitListState createState() => _WaitListState();
}

class _WaitListState extends State<WaitList> {
  CalendarController _calendarcontroller;
  ReservationServices get reservationService => GetIt.I<ReservationServices>();
  APIResponse<List<Reservation>> _apiResponse;
  bool _isLoading = false;
  String errorMessage;

  @override
  void initState() {
    _fetchReservations();
    super.initState();
    _calendarcontroller = CalendarController();
  }

  @override
  void dispose() {
    super.dispose();
    _calendarcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Waitlist',
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TableCalendar(
                  startingDayOfWeek: StartingDayOfWeek.sunday,
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
                    titleTextStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  calendarController: _calendarcontroller,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: KBlue,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : _buildEventsList(_apiResponse.data),
              )
            ],
          ),
        ),
      ),
    );
  }

  _fetchReservations() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await reservationService
        .getReservationsList(widget.restaurantID.toString());
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
            if (data[index].etat == 0) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailReservation(
                                reservationId: data[index].id,
                              ))).then((__) => _fetchReservations());
                },
                child: WaitCard(
                  delete: () async {
                    final result = await showDialog(
                        context: context, builder: (_) => FloorDelete());

                    if (result) {
                      final deleteResult = await reservationService
                          .deleteReservation(data[index].id.toString());
                      _fetchReservations();

                      var message = 'The reservation is declined';

                      return deleteResult?.data ?? false;
                    }
                    print(result);
                    return result;
                  },
                  confirm: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    final reservationUp = Reservation(
                      id: data[index].id,
                      restaurantId: widget.restaurantID,
                      nomPersonne: data[index].nomPersonne,
                      nbPersonne: data[index].nbPersonne,
                      dateReservation: data[index].dateReservation,
                      heureReservation: data[index].heureReservation,
                      etat: 1,
                    );

                    final result = await reservationService
                        .updateReservation(
                            data[index].id.toString(), reservationUp);
                    print(reservationUp.id);
                    print(reservationUp.etat);
                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = 'This reservation is confirmed';

                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text(title),
                              content: Text(text),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReservationtList()));
                                    },
                                    child: Text('ok')),
                              ],
                            ));
                  },
                  guestname: data[index].nomPersonne,
                  nbPersonne: data[index].nbPersonne.toString(),
                  reservationId: data[index].id,
                  reservationDate: data[index].dateReservation,
                  reservationTime: data[index].heureReservation,
                ),
              );
            } else {
              return Container();
            }
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
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
}
