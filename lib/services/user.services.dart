import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/models/Restaurant.dart';
import 'package:tawelti/models/user.dart';

class UserServices {
  static const API = 'http://10.0.2.2:3000/';

  Future<APIResponse<User>> getUserProfile(String userId) {
    return http
        .get(
      Uri.parse(API + 'users/' + userId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<User>(data: User.fromJson(jsonData));
      }
      return APIResponse<User>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<User>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Restaurant>> getUserRestauarnt(String userId) {
    return http
        .get(
      Uri.parse(API + 'users/restaurant/' + userId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Restaurant>(data: Restaurant.fromJson(jsonData));
      }
      return APIResponse<Restaurant>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Restaurant>(error: true, errorMessage: 'An error occured'));
  }


  Future<APIResponse<bool>> updateUser(String userID, User item) {
    return http.put(Uri.parse(API + 'users/update/' + userID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  // getProfile(apiUrl,token) async{
  //   return await http.get(
  //     Uri.parse(API+apiUrl),
  //     // Send authorization headers to the backend.
  //     headers: {
  //       HttpHeaders.authorizationHeader:token,
  //     },
  //   );
  // }
}
