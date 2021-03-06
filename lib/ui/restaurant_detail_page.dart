import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:dicoding_restaurant_app/widgets/data_not_found.dart';
import 'package:dicoding_restaurant_app/widgets/detail_restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;
  const RestaurantDetailPage({@required this.restaurant});

  Widget _buildWidget(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, _) {
        if (provider.stateDetail == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.stateDetail == ResultState.HasData) {
          var restaurantDetail = provider.resultDetailRestaurant.restaurant;

          return DetailRestaurant(
            restaurantDetail: restaurantDetail,
          );
        } else if (provider.stateDetail == ResultState.NoData) {
          print(provider.message);
          return DataNotFound(icon: Icons.restaurant);
        } else if (provider.stateDetail == ResultState.Error) {
          print(provider.message);
          return DataNotFound(icon: Icons.error_outline);
        } else {
          print(provider.message);
          return DataNotFound(icon: Icons.error_outline);
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: _buildWidget(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(restaurant.name),
        transitionBetweenRoutes: false,
      ),
      child: _buildWidget(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
