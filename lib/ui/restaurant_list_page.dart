import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/model/restaurants.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
        future:
            DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurants = parseRestaurant(snapshot.data);
          return GridView.builder(
              itemCount: restaurants == null ? 0 : restaurants.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return _builderRestaurantItem(context, restaurants[index]);
              });
        });
  }

  Widget _builderRestaurantItem(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
      child: Card(
        elevation: 5.0,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.all(5),
        child: GridTile(
          child: Hero(
            tag: restaurant.pictureId,
            child: Image.network(
              restaurant.pictureId,
              fit: BoxFit.cover,
            ),
          ),
          header: Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow[900],
                ),
                Text(
                  restaurant.rating.toString(),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.yellow[900]),
                ),
              ],
            ),
          ),
          footer: Container(
            color: Colors.white70,
            padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: primaryColor),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                    ),
                    Text(restaurant.city,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: primaryColor))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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
