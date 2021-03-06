import 'package:dicoding_restaurant_app/common/utils.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:dicoding_restaurant_app/widgets/data_not_found.dart';
import 'package:dicoding_restaurant_app/widgets/form_search.dart';
import 'package:dicoding_restaurant_app/widgets/list_restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearch extends StatefulWidget {
  static const routeName = '/restaurant_search';

  @override
  _RestaurantSearchState createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {
  String query;

  Widget _buildList(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FormSearch(
            onSearch: (q) {
              setState(() {
                query = q;
                Provider.of<RestaurantProvider>(context, listen: false)
                    .getRestaurantsByQuery(q);
              });
            },
          ),
          Expanded(
            child: query == null
                ? DataNotFound(icon: Icons.search)
                : _buildConsumer(context),
          ),
        ],
      ),
    );
  }

  Widget _buildConsumer(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, _) {
        if (provider.stateSearch == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.stateSearch == ResultState.HasData) {
          return ListRestaurant(
            restaurants: provider.resultSearchRestaurants.restaurants,
          );
        } else if (provider.stateSearch == ResultState.NoData) {
          print(provider.message);
          return DataNotFound(icon: Icons.search);
        } else if (provider.stateSearch == ResultState.Error) {
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
