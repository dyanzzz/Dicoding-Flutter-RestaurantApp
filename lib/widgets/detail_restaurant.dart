import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurantDetail;
  const DetailRestaurant({Key key, @required this.restaurantDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget containerRow(icon) {
      return new Container(
        child: Icon(icon),
        decoration: BoxDecoration(border: Border.all(color: primaryColor)),
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        width: 100.0,
        height: 100.0,
      );
    }

    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurantDetail.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: restaurantDetail.pictureId,
                        child: Image.network(ApiService.mediumImage +
                            restaurantDetail.pictureId),
                      ),
                      Positioned(
                        right: 10.0,
                        bottom: 10.0,
                        child: isFavorite
                            ? FloatingActionButton(
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                backgroundColor: Colors.white54,
                                onPressed: () {
                                  provider.removeFavorite(restaurantDetail.id);
                                },
                              )
                            : FloatingActionButton(
                                child: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                backgroundColor: Colors.white54,
                                onPressed: () {
                                  provider.addFavorite(restaurantDetail);
                                },
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
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 15.0,
                              ),
                              Text(
                                restaurantDetail.city,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            children: [
                              RatingBarIndicator(
                                rating: restaurantDetail.rating.toDouble(),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.yellow[900],
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                unratedColor: Colors.yellow[900].withAlpha(50),
                                direction: Axis.horizontal,
                              ),
                              Text(
                                restaurantDetail.rating.toString(),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow[900],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Foods Menu",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurantDetail.menus.foods.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      containerRow(Icons.restaurant),
                                      Text(
                                        restaurantDetail
                                            .menus.foods[index].name,
                                      ),
                                      Text(
                                        "IDR 20.000",
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Drinks Menu",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurantDetail.menus.drinks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      containerRow(Icons.local_bar),
                                      Text(
                                        restaurantDetail
                                            .menus.drinks[index].name,
                                      ),
                                      Text(
                                        "IDR 10.000",
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
