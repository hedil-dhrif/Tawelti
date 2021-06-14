import 'dart:convert';

import 'package:tawelti/api/api_Response.dart';
import 'package:http/http.dart' as http;
import 'package:tawelti/models/table.dart';
import 'package:tawelti/models/waiter.dart';
import 'package:tawelti/models/zone.dart';

class ZoneServices {
  static const API = 'http://10.0.2.2:3000/';

  Future<APIResponse<List<Zone>>> getZonesList(String etageID) {
    return http
        .get(
      Uri.parse(API + 'etages/zones/'+etageID),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final floors = <Zone>[];
        for (var item in jsonData) {
          floors.add(Zone.fromJson(item));
        }
        return APIResponse<List<Zone>>(data: floors);
      }
      return APIResponse<List<Zone>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Zone>>(
            error: true, errorMessage: 'An error occured'));
  }
  //
  Future<APIResponse<List<RestaurantTable>>> getZoneTablesList(String zoneID) {
    return http
        .get(
      Uri.parse(API + 'zones/tables/' + zoneID),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final floors = <RestaurantTable>[];
        for (var item in jsonData) {
          floors.add(RestaurantTable.fromJson(item));
        }
        return APIResponse<List<RestaurantTable>>(data: floors);
      }
      return APIResponse<List<RestaurantTable>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<RestaurantTable>>(
            error: true, errorMessage: 'An error occured'));
  }

  // Future getZoneTablesList(String zoneID) {
  //   return http
  //       .get(
  //     Uri.parse(API + 'zones/tables/' + zoneID),
  //   );
  // }

  Future<APIResponse<Zone>> getZone(String zoneId) {
    return http
        .get(
      Uri.parse(API + 'zones/' + zoneId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Zone>(data: Zone.fromJson(jsonData));
      }
      return APIResponse<Zone>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<Zone>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Waiter>> getZoneWaiter(String zoneId) {
    return http
        .get(
      Uri.parse(API + 'zones/serveur/' + zoneId),
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

  Future<APIResponse<bool>> updateZone(String noteID, Zone item) {
    return http
        .put(Uri.parse(API + 'zones/' + noteID),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(item))
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> createZone(Zone item) {
    return http
        .post(Uri.parse(API + 'zones/create'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(item))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteZone(String noteID) {
    return http.delete(Uri.parse(API + 'zones/' + noteID),
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
