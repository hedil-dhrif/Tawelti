import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/CustomCard.dart';

class WaitList extends StatefulWidget {
  @override
  _WaitListState createState() => _WaitListState();
}

class _WaitListState extends State<WaitList> {
  CalendarController _calendarcontroller;

  @override
  void initState() {
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
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          title: AppBarWidget(
            title: 'Wait list',
            icon: Icons.close,
            onpressed: () {},
          )),
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
                padding: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: KBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomCard(),
                    SizedBox(
                      height: 10,
                    ),
                    CustomCard(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
