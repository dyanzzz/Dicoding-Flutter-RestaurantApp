import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/list_restaurant_result.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/widgets/card_restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  Future<ListRestaurantResult> _restaurant;

  @override
  void initState() {
    _restaurant = ApiService().listRestaurants();
    super.initState();
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
        future: _restaurant,
        builder: (context, AsyncSnapshot<ListRestaurantResult> snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.restaurants == null
                    ? 0
                    : snapshot.data.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = snapshot.data.restaurants[index];
                  return CardRestaurant(
                    restaurant: restaurant,
                    onPressed: () => Navigator.pushNamed(
                        context, RestaurantDetailPage.routeName,
                        arguments: restaurant),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Text("");
            }
          }
        });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant MantApp'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Restaurant MantApp Ios"),
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
