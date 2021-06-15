import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelti/models/etablissement.dart';
import 'package:tawelti/screens/Addfloor/test.dart';
import 'package:tawelti/screens/authentification/SignInPage.dart';
import 'package:tawelti/services/ambiance.services.dart';
import 'package:tawelti/services/cuisine.services.dart';
import 'package:tawelti/services/etablissement.services.dart';
import 'package:tawelti/services/event.services.dart';
import 'package:tawelti/services/floor.services.dart';
import 'package:tawelti/services/general.services.dart';
import 'package:tawelti/services/reservation.services.dart';
import 'package:tawelti/services/restaurant.services.dart';
import 'package:tawelti/services/table.services.dart';
import 'package:tawelti/services/user.services.dart';
import 'package:tawelti/services/waiter.services.dart';
import 'package:tawelti/services/zone.services.dart';


void setupLocator() {
  GetIt.I.registerLazySingleton(() => FloorServices());
  GetIt.I.registerLazySingleton(() => ZoneServices());
  GetIt.I.registerLazySingleton(() => TableServices());
  GetIt.I.registerLazySingleton(() => EventServices());
  GetIt.I.registerLazySingleton(() => WaiterServices());
  GetIt.I.registerLazySingleton(() => UserServices());
  GetIt.I.registerLazySingleton(() => RestaurantServices());
  GetIt.I.registerLazySingleton(() => ReservationServices());
  GetIt.I.registerLazySingleton(() => AmbianceServices());
  GetIt.I.registerLazySingleton(() => GeneralServices());
  GetIt.I.registerLazySingleton(() => EtablissementServices());
  GetIt.I.registerLazySingleton(() => CuisineServices());
}

void main() {
  setupLocator();
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async{
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token!= null){
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn?Test():SignIn(),
    );
  }
}
