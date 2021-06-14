import 'dart:convert';

import 'package:tawelti/api/api_Response.dart';
import 'package:http/http.dart' as http;
import 'package:tawelti/models/Cuisine.dart';
import 'package:tawelti/models/Restaurant.dart';
import 'package:tawelti/models/ambiance.dart';
import 'package:tawelti/models/etablissement.dart';
import 'package:tawelti/models/event.dart';
import 'package:tawelti/models/general.dart';

class RestaurantServices {
  static const API = 'http://10.0.2.2:3000/';

  Future<APIResponse<bool>> createRestaurant(Restaurant item) {
    return http
        .post(Uri.parse(API + 'restaurant/AddRestaurant'),
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

  Future<APIResponse<Restaurant>> getRestaurant(String restaurantId) {
    return http
        .get(
      Uri.parse(API + 'restaurant/' + restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Restaurant>(data: Restaurant.fromJson(jsonData));
      }
      return APIResponse<Restaurant>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<Restaurant>(
            error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<List<Event>>> getRestaurantsListEvents(
      String restaurantId) {
    return http
        .get(
      Uri.parse(API + 'restaurants/evenement/' + restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Event>[];
        for (var item in jsonData) {
          events.add(Event.fromJson(item));
        }
        return APIResponse<List<Event>>(data: events);
      }
      return APIResponse<List<Event>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Event>>(
            error: true, errorMessage: 'An error occured'));
  }



  Future<APIResponse<List<Etablissement>>> getRestaurantsListEtablissement(
      String restaurantId) {
    return http
        .get(
      Uri.parse(API + 'restaurants/etablissement/' + restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Etablissement>[];
        for (var item in jsonData) {
          events.add(Etablissement.fromJson(item));
        }
        return APIResponse<List<Etablissement>>(data: events);
      }
      return APIResponse<List<Etablissement>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Etablissement>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<List<Cuisine>>> getRestaurantsListCuisine(
      String restaurantId) {
    return http
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

  Future<APIResponse<List<General>>> getRestaurantsListGeneral(
      String restaurantId) {
    return http
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

  Future<APIResponse<bool>> updateRestaurant(String restoID, Restaurant item) {
    return http
        .put(Uri.parse(API + 'restaurant/UpdateRestaurant/' + restoID),
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

  Future<APIResponse<bool>> deleteRestaurant(String restaurantID) {
    return http.delete(Uri.parse(API + 'restaurants/' + restaurantID),
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
