import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tawelti/models/reservation.dart';
import 'package:tawelti/services/reservation.services.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  final reservationService = ReservationServices();

  Reservation reservation = Reservation(
    id: 2,
    dateReservation: DateTime.utc(2021, 22, 1),
    heureReservation: DateTime.utc(12, 00, 00),
    userId: 10,
    restaurantId: 1,
    tableId: 20,
  );

  test('add reservation to database', () async {
    http.Client mockitoExample = MockitoExample();

    when(mockitoExample.post(
            Uri.parse('http://10.0.2.2:3000/reservations/create'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode(reservation.toJson())))
        .thenAnswer((value) async {
      return http.Response('{"id": "2"}', 200);
    });
    expect(
        await reservationService
            .createReservation(mockitoExample, reservation)
            .then((response) => response),
        {'id': '2'});
    print(
      await reservationService
          .createReservation(mockitoExample, reservation)
          .then((response) => response),);
  });

  test('returns reservation from database', () async {
    http.Client mockitoExample = MockitoExample();

    when(mockitoExample.get(Uri.parse('http://10.0.2.2:3000/reservations/1')))
        .thenAnswer((value) async {
      return http.Response('{"id": "1"}', 200);
    });
    expect(
        await reservationService
            .getReservation(mockitoExample)
            .then((response) => response),
        {'id': '1'});
    var result = await reservationService
        .getReservation(mockitoExample)
        .then((response) => response);
    print(result);
  });
////////////
  test('gives us an exception if we get error in our http call', () {
    final mockitoExample = MockitoExample();

    when(mockitoExample.get(Uri.parse('http://10.0.2.2:3000/reservations/1')))
        .thenAnswer((value) async {
      return http.Response('Not Found', 404);
    });

    expect(
        reservationService.getReservation(mockitoExample), throwsException);
  });
 }

class MockitoExample extends Mock implements http.Client {}
