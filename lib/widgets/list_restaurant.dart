import 'package:dicoding_restaurant_app/common/navigation.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:provider/provider.dart';

import '../data/model/restaurant.dart';
import '../widgets/card_restaurant.dart';
import '../ui/restaurant_detail_page.dart';

import 'package:flutter/material.dart';

class ListRestaurant extends StatelessWidget {
  final List<Restaurant> restaurants;
  ListRestaurant({Key key, this.restaurants}) : super(key: key);

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
          onPressed: () {
            Provider.of<RestaurantProvider>(context, listen: false)
                .getRestaurantsById(restaurant.id);

            Navigation.intentWithData(
                RestaurantDetailPage.routeName, restaurant);
          },
        );
      },
    );
  }
}
