import 'package:dicoding_restaurant_app/common/navigation.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:provider/provider.dart';

import '../data/model/restaurant.dart';
import '../widgets/card_restaurant.dart';
import '../ui/restaurant_detail_page.dart';

import 'package:flutter/material.dart';

class ListRestaurant extends StatefulWidget {
  final List<Restaurant> restaurants;
  ListRestaurant({Key key, this.restaurants}) : super(key: key);

  @override
  _ListRestaurantState createState() => _ListRestaurantState();
}

class _ListRestaurantState extends State<ListRestaurant> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: widget.restaurants == null ? 0 : widget.restaurants.length,
      itemBuilder: (context, index) {
        var restaurant = widget.restaurants[index];

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
