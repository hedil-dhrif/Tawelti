import 'dart:convert';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/models/floor.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;

class FloorServices {

  Client client = Client();

  static const API = 'http://10.0.2.2:3000/';

  Future<APIResponse<List<Floor>>> getFloorsList(String restaurantId) {
    return http
        .get(
      Uri.parse(API + 'restaurants/etage/'+restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final floors = <Floor>[];
        for (var item in jsonData) {
          floors.add(Floor.fromJson(item));
        }
        return APIResponse<List<Floor>>(data: floors);
      }
      return APIResponse<List<Floor>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Floor>>(
            error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Floor>> getFloor(String floorId) {
    return http
        .get(
      Uri.parse(API + 'etages/' + floorId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Floor>(data: Floor.fromJson(jsonData));
      }
      return APIResponse<Floor>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<Floor>(error: true, errorMessage: 'An error occured'));
  }

  // Future getFloor(client) async {
  //   final response =
  //   await client.get(Uri.parse(API + 'etages/7'));
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('exception occured!!!!!!');
  //   }
  // }

  Future<APIResponse<bool>> createFloor(Floor item) {
    return client
        .post(Uri.parse(API + 'etages/create'),
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

  Future createFloorTest(client,item) async {
    final response =
    await client.post(Uri.parse(API + 'etages/create'),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'},body: jsonEncode(item.toJson()));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('exception occured!!!!!!');
    }
  }

  Future<APIResponse<bool>> updateFloor(String noteID, Floor item) {
    return http.put(Uri.parse(API + 'etages/' + noteID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item)).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteFloor(String noteID) {
    return http.delete(Uri.parse(API + 'etages/' + noteID), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}
