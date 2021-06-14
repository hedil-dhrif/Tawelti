import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tawelti/models/floor.dart';
import 'package:tawelti/services/floor.services.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  final floorService = FloorServices();

  Floor floor = Floor(
    id: 8,
    nom: "etage3",
  );

  test('add floor to database', () async {
    http.Client mockitoExample = MockitoExample();

    when(mockitoExample.post(
        Uri.parse('http://10.0.2.2:3000/etages/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(floor.toJson())))
        .thenAnswer((value) async {
      return http.Response('{"id": 8}', 200);
    });
    expect(
        await floorService
            .createFloorTest(mockitoExample,floor)
            .then((response) => response),
        {'id': '8'});
    var result = await floorService
        .createFloorTest(mockitoExample,floor)
        .then((response) => response);
    print(result);
  });

  test('returns floor from database', () async {
    http.Client mockitoExample = MockitoExample();

    when(mockitoExample.get(Uri.parse('http://10.0.2.2:3000/etages/7')))
        .thenAnswer((value) async {
      return http.Response('{"id": "7"}', 200);
    });
    expect(
        await floorService
            .getFloor(mockitoExample)
            .then((response) => response),
        {'id': '7'});
    var result = await floorService
        .getFloor(mockitoExample)
        .then((response) => response);
    print(result);
  });


}
class MockitoExample extends Mock implements http.Client {}
