import 'dart:convert';

import 'package:dicoding_restaurant_app/data/model/restaurant.dart';

ListRestaurantResult restaurantResultFromJson(String str) =>
    ListRestaurantResult.fromJson(json.decode(str));

String restaurantResultToJson(ListRestaurantResult data) =>
    json.encode(data.toJson());

class ListRestaurantResult {
  ListRestaurantResult({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory ListRestaurantResult.fromJson(Map<String, dynamic> json) =>
      ListRestaurantResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJsonList(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants":
            List<dynamic>.from(restaurants.map((x) => x.toJsonList())),
      };
}
