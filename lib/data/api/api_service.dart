import 'dart:convert';

import 'package:dicoding_restaurant_app/common/utils.dart';
import 'package:dicoding_restaurant_app/data/model/detail_restaurant_result.dart';
import 'package:dicoding_restaurant_app/data/model/list_restaurant_result.dart';
import 'package:http/http.dart' as http;

const query = "";

class ApiService {
  static final String _baseUrl = AppConfig.baseUrl;
  static final String _apiKey = AppConfig.apiKey;
  static final String smallImage = AppConfig.smallImage;
  static final String mediumImage = AppConfig.mediumImage;
  static final String largeImage = AppConfig.largeImage;

  static final String _getListRestaurant = "list/";
  static final String _getDetailRestaurant = "detail/";
  static final String _getSearchRestaurant = "search?q=";
  static final String _setReviewRestaurant = "review/";

  Future<ListRestaurantResult> listRestaurants({query = ""}) async {
    String url;
    if (query == "") {
      url = _baseUrl + _getListRestaurant;
    } else {
      url = _baseUrl + _getSearchRestaurant + query;
    }
    final response = await http.get(url);

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
