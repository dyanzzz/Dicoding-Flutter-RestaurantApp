import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/model/restaurants.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;
  const RestaurantDetailPage({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
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
          title: Text(restaurant.name),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(
                          restaurant.pictureId,
                        ),
                      ),
                      Container(
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow[900]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        Container(
                            child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                            ),
                            Text(
                              restaurant.city,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ],
                        )),
                        Divider(
                          color: Colors.grey,
                        ),
                        Text(
                          restaurant.description,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Food Menu",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    ListView.builder(
                        itemCount: restaurant.menus.foods.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Text(
                            "- " + restaurant.menus.foods[index].name,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          );
                        }),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Drink Menu",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    ListView.builder(
                        itemCount: restaurant.menus.drinks.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Text(
                            "- " + restaurant.menus.drinks[index].name,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          );
                        }),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
