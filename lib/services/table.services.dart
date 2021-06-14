import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/models/table.dart';
import 'package:http/http.dart' as http;

class TableServices{

  static const API = 'http://10.0.2.2:3000/';
  Future<APIResponse<bool>> createTable(RestaurantTable item) {
    return http
        .post(Uri.parse(API + 'tables/create'),
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

  Future<APIResponse<List<RestaurantTable>>> getTablesList() {
    return http
        .get(
      Uri.parse(API + 'tables'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final tables = <RestaurantTable>[];
        for (var item in jsonData) {
          tables.add(RestaurantTable.fromJson(item));
        }
        return APIResponse<List<RestaurantTable>>(data: tables);
      }
      return APIResponse<List<RestaurantTable>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<RestaurantTable>>(
        error: true, errorMessage: 'An error occured'));
  }


  Future<APIResponse<RestaurantTable>> getTable(String eventId) {
    return http
        .get(
      Uri.parse(API + 'tables/' + eventId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<RestaurantTable>(data: RestaurantTable.fromJson(jsonData));
      }
      return APIResponse<RestaurantTable>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<RestaurantTable>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> updateTable(String waiterID, RestaurantTable item) {
    return http.put(Uri.parse(API + 'tables/' + waiterID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteTable(String noteID) {
    return http.delete(Uri.parse(API + 'tables/' + noteID),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}