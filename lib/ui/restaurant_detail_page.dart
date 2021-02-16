import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/detail_restaurant_result.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/detail_restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;
  const RestaurantDetailPage({@required this.restaurant});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  Widget _buildWidget(BuildContext context) {
    final api = Provider.of<ApiService>(context);

    return FutureBuilder(
        future: api.detailRestaurant(widget.restaurant.id),
        builder: (context, AsyncSnapshot<DetailRestaurantResult> snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.hasData) {
              var restaurantDetail = snapshot.data.restaurant;
              return DetailRestaurant(
                restaurantDetail: restaurantDetail,
              );
            } else if (snapshot.hasError) {
              print("= = = = = = " + snapshot.error.toString());
              return Center(
                child: Text("Connection Error, please try again."),
              );
            } else {
              return Text("");
            }
          }
        });
  }

  Widget _buildAndroid(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: secondaryColor,
            tabs: [
              Tab(
                text: "Description",
              ),
              Tab(
                text: "Foods",
              ),
              Tab(
                text: "Drinks",
              ),
            ],
          ),
          title: Text(widget.restaurant.name),
        ),
        body: _buildWidget(context),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Restaurant MantApp Ios"),
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
