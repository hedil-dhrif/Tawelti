import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/models/Cuisine.dart';
import 'package:tawelti/models/ambiance.dart';
import 'package:tawelti/models/etablissement.dart';
import 'package:tawelti/models/event.dart';
import 'package:tawelti/models/general.dart';

class CuisineServices{
  Client client = Client();

  static const API = 'http://10.0.2.2:3000/';

  Future<APIResponse<List<Cuisine>>> getRestaurantsListCuisine(
      String restaurantId) {
    return client
        .get(
      Uri.parse(API + 'restaurants/cuisine/' + restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Cuisine>[];
        for (var item in jsonData) {
          events.add(Cuisine.fromJson(item));
        }
        return APIResponse<List<Cuisine>>(data: events);
      }
      return APIResponse<List<Cuisine>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Cuisine>>(
        error: true, errorMessage: 'An error occured'));
  }
  Future<APIResponse<bool>> addCuisine(Cuisine item) {
    return client
        .post(Uri.parse(API + 'cuisines/create'),
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

  Future<APIResponse<bool>> updateCuisine(String ID,Cuisine item) {
    return client.put(Uri.parse(API + 'cuisines/' + ID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteCuisine(String ID) {
    return client.delete(Uri.parse(API + 'cuisines/' + ID), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}