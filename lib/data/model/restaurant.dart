import 'package:dicoding_restaurant_app/data/model/category.dart';
import 'package:dicoding_restaurant_app/data/model/customer_review.dart';
import 'package:dicoding_restaurant_app/data/model/menus.dart';

class Restaurant {
  Restaurant.list({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  Restaurant.detail({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  String address;
  List<Category> categories;
  Menus menus;
  List<CustomerReview> customerReviews;

  // list
  factory Restaurant.fromJsonList(Map<String, dynamic> json) => Restaurant.list(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJsonList() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };

  // detail
  factory Restaurant.fromJsonDetail(Map<String, dynamic> json) =>
      Restaurant.detail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJsonDetail() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}
