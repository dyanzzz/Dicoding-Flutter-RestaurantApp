import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:dicoding_restaurant_app/widgets/data_not_found.dart';

import '../common/utils.dart';
import '../ui/restaurant_search.dart';
import '../widgets/list_restaurant.dart';
import '../widgets/platform_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == ResultState.HasData) {
          return ListRestaurant(
            restaurants: provider.result.restaurants,
          );
        } else if (provider.state == ResultState.NoData) {
          print(provider.message);
          return DataNotFound(icon: Icons.restaurant);
        } else if (provider.state == ResultState.Error) {
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
        title: Text(AppConfig.appName),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RestaurantSearch()));
            },
          ),
        ],
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppConfig.appName),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
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
