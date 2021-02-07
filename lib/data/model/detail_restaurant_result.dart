import 'dart:convert';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';

DetailRestaurantResult restaurantDetailResultFromJson(String str) =>
    DetailRestaurantResult.fromJson(json.decode(str));

String restaurantDetailResultToJson(DetailRestaurantResult data) =>
    json.encode(data.toJson());

class DetailRestaurantResult {
  DetailRestaurantResult({
    this.error,
    this.message,
    this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory DetailRestaurantResult.fromJson(Map<String, dynamic> json) =>
      DetailRestaurantResult(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJsonDetail(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJsonDetail(),
      };
}
