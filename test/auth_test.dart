import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:tawelti/api/api.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/models/floor.dart';
import 'package:tawelti/models/user.dart';
import 'package:tawelti/services/floor.services.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  final callApi = CallApi();

  User user = User(
    id: 10,
    email: "malekSouissi@gmail.com",
    password: "flutter",
    username: "flutterSlayer",
    phone: "20147896",
    resetLink: "resetLink",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  test('register', () async {
    http.Client mockitoExample = MockitoExample();

    when(mockitoExample.post(
        Uri.parse('http://10.0.2.2:3000/users/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user.toJson())))
        .thenAnswer((value) async {
      return http.Response('{"email": ""}', 200);
    });
    expect(
        await callApi
            .register(mockitoExample, user)
            .then((response) => response),
        {'email': 'malekSouissi@gmail.com'});
    print(
      await callApi
          .register(mockitoExample, user)
          .then((response) => response),);
  });
  // test('Register', () async {
  //   final callApi = CallApi();
  //
  //   http.Client mockitoExample = MockitoExample();
  //
  //   when(mockitoExample.post(
  //     Uri.parse('http://10.0.2.2:3000/users/register'),
  //     headers: {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json;charset=UTF-8'
  //     },
  //     body: jsonEncode(user.toJson()),
  //   )).thenAnswer((value) async {
  //     return http.Response('{"id": "10"}', 200);
  //   });
  //
  //   expect(
  //       await callApi
  //           .register(user, mockitoExample)
  //           .then((response) => response),
  //       {'id': '10'});
  //   // print(await callApi
  //   //     .login(mockitoExample, user)
  //   //     .then((response) => response.data));
  // });

  // test('afficher profile', () async {
  //   final callApi = CallApi();
  //
  //   final client = MockClient();
  //
  //   when(client.post(Uri.parse('http://10.0.2.2:3000/users/1'),
  //       body: jsonEncode(user),
  //       headers: {"content-type": "application/json"}))
  //       .thenAnswer((_) async => http.Response('{"status": 201}', 201));
  //
  //   expect(await callApi.login(user), isInstanceOf<APIResponse<bool>>());
  //   print(callApi.login(user).then((response) => response.data));
  //
  // });
}

class MockitoExample extends Mock implements http.Client {}
