import 'package:dicoding_restaurant_app/common/utils.dart';
import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_search.dart';
import 'package:dicoding_restaurant_app/widgets/error.dart';
import 'package:dicoding_restaurant_app/widgets/list_restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  Widget _buildList(BuildContext context) {
    final api = Provider.of<ApiService>(context);

    return FutureBuilder(
        future: api.listRestaurants(),
        builder: (context, snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return ListRestaurant(restaurants: snapshot.data.restaurants);
            } else if (snapshot.hasError) {
              print(" ========== " + snapshot.error.toString());
              return ErrorConnection();
            } else {
              return Text("");
            }
          }
        });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.AppName),
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
