import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;

import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/models/floor.dart';
import 'package:tawelti/models/waiter.dart';

class WaiterServices{
  Client client = Client();

  static const API = 'http://10.0.2.2:3000/';

  Future<APIResponse<List<Waiter>>> getWaitersList(String restaurantId) {
    return client
        .get(
      Uri.parse(API + 'restaurants/serveur/'+restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final floors = <Waiter>[];
        for (var item in jsonData) {
          floors.add(Waiter.fromJson(item));
        }
        return APIResponse<List<Waiter>>(data: floors);
      }
      return APIResponse<List<Waiter>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Waiter>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Waiter>> getWaiter(String waiterId) {
    return client
        .get(
      Uri.parse(API + 'serveurs/' + waiterId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Waiter>(data: Waiter.fromJson(jsonData));
      }
      return APIResponse<Waiter>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Waiter>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> createWaiter(Waiter item) {
    return client
        .post(Uri.parse(API + 'serveurs/create'),
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

  Future<APIResponse<bool>> updateWaiter(String waiterID, Waiter item) {
    return http.put(Uri.parse(API + 'serveurs/' + waiterID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteWaiter(String waiterID) {
    return http.delete(Uri.parse(API + 'serveurs/' + waiterID), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}