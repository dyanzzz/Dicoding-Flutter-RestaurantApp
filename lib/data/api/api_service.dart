import 'dart:convert';

import 'package:dicoding_restaurant_app/data/model/detail_restaurant_result.dart';
import 'package:dicoding_restaurant_app/data/model/list_restaurant_result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final String _apiKey = "12345";
  static final String smallImage =
      "https://restaurant-api.dicoding.dev/images/small/";
  static final String mediumImage =
      "https://restaurant-api.dicoding.dev/images/medium/";
  static final String largeImage =
      "https://restaurant-api.dicoding.dev/images/large/";

  static final String _getListRestaurant = "list/";
  static final String _getDetailRestaurant = "detail/";
  static final String _getSearchRestaurant = "search?q=";
  static final String _setReviewRestaurant = "review/";

  Future<ListRestaurantResult> listRestaurants() async {
    final response = await http.get(_baseUrl + _getListRestaurant);

    if (response.statusCode == 200) {
      return ListRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<DetailRestaurantResult> detailRestaurant(id) async {
    final response = await http.get(_baseUrl + _getDetailRestaurant + id);

    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }
}
