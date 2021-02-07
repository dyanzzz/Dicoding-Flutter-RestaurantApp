import 'dart:convert';

import 'package:dicoding_restaurant_app/data/model/restaurant.dart';

SearchRestaurantResult searchRestaurantResultFromJson(String str) =>
    SearchRestaurantResult.fromJson(json.decode(str));

String searchRestaurantResultToJson(SearchRestaurantResult data) =>
    json.encode(data.toJson());

class SearchRestaurantResult {
  SearchRestaurantResult({
    this.error,
    this.founded,
    this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory SearchRestaurantResult.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJsonList(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants":
            List<dynamic>.from(restaurants.map((x) => x.toJsonList())),
      };
}
