import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/models/ambiance.dart';
import 'package:tawelti/models/event.dart';
import 'package:tawelti/models/general.dart';

class GeneralServices{
  Client client = Client();

  static const API = 'http://10.0.2.2:3000/';
  Future<APIResponse<List<General>>> getRestaurantsListGeneral(
      String restaurantId) {
    return client
        .get(
      Uri.parse(API + 'restaurants/general/' + restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <General>[];
        for (var item in jsonData) {
          events.add(General.fromJson(item));
        }
        return APIResponse<List<General>>(data: events);
      }
      return APIResponse<List<General>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<General>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> addGeneral(General item) {
    return client
        .post(Uri.parse(API + 'generals/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> updateGeneral(String ID, Ambiance item) {
    return client.put(Uri.parse(API + 'generals/' + ID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteGeneral(String ID) {
    return client.delete(Uri.parse(API + 'generals/' + ID), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}