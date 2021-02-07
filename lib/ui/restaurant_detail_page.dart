import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/detail_restaurant_result.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;
  const RestaurantDetailPage({@required this.restaurant});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  Future<DetailRestaurantResult> _restaurant;

  @override
  void initState() {
    _restaurant = ApiService().detailRestaurant(widget.restaurant.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Widget _buildList(BuildContext context) {
    return FutureBuilder(
        future: _restaurant,
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
                    title: Text(restaurantDetail.name),
                  ),
                  body: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: <Widget>[
                                Hero(
                                  tag: restaurantDetail.pictureId,
                                  child: Image.network(ApiService.mediumImage +
                                      restaurantDetail.pictureId),
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
                                        restaurantDetail.rating.toString(),
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
                                    restaurantDetail.name,
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
                                        restaurantDetail.city,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ],
                                  )),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    restaurantDetail.description,
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
                                  itemCount:
                                      restaurantDetail.menus.foods.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      "- " +
                                          restaurantDetail
                                              .menus.foods[index].name,
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
                                  itemCount:
                                      restaurantDetail.menus.drinks.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      "- " +
                                          restaurantDetail
                                              .menus.drinks[index].name,
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
/*
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
  */
/*
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
          title: Text(widget.restaurant.name),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: widget.restaurant.pictureId,
                        child: Image.network(
                          widget.restaurant.pictureId,
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
                              widget.restaurant.rating.toString(),
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
                          widget.restaurant.name,
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
                              widget.restaurant.city,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ],
                        )),
                        Divider(
                          color: Colors.grey,
                        ),
                        Text(
                          widget.restaurant.description,
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
                        itemCount: widget.restaurant.menus.foods.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Text(
                            "- " + widget.restaurant.menus.foods[index].name,
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
                        itemCount: widget.restaurant.menus.drinks.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Text(
                            "- " + widget.restaurant.menus.drinks[index].name,
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
  */
}
