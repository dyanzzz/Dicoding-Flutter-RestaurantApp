import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurantDetail;
  const DetailRestaurant({Key key, @required this.restaurantDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var container = new Container(
      child: Icon(Icons.fastfood),
      decoration: BoxDecoration(border: Border.all(color: primaryColor)),
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      width: 200.0,
      height: 200.0,
    );

    return TabBarView(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Hero(
                    tag: restaurantDetail.pictureId,
                    child: Image.network(
                        ApiService.mediumImage + restaurantDetail.pictureId),
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
              ),
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
                itemCount: restaurantDetail.menus.foods.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text(
                    "- " + restaurantDetail.menus.foods[index].name,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  );
                },
              ),
            ],
          ),
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
                itemCount: restaurantDetail.menus.drinks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text(
                    "- " + restaurantDetail.menus.drinks[index].name,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
