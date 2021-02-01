import 'dart:convert';
import 'package:dicoding_restaurant_app/data/model/menus.dart';

class Restaurant {
  Menus menus;
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurant(
      {this.menus,
      this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating});

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'].toDouble();
    menus = restaurant['menus'] != null
        ? new Menus.fromJson(restaurant["menus"])
        : null;
  }
}

List<Restaurant> parseRestaurant(String json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
