import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/card_restaurant.dart';
import 'package:flutter/material.dart';

import '../ui/restaurant_detail_page.dart';

class ListRestaurant extends StatelessWidget {
  final List<Restaurant> restaurants;
  ListRestaurant({this.restaurants});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: restaurants == null ? 0 : restaurants.length,
      itemBuilder: (context, index) {
        var restaurant = restaurants[index];
        return CardRestaurant(
          restaurant: restaurant,
          onPressed: () => Navigator.pushNamed(
              context, RestaurantDetailPage.routeName,
              arguments: restaurant),
        );
      },
    );
  }
}
