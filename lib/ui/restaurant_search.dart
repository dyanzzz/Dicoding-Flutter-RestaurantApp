import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/widgets/form_search.dart';
import 'package:dicoding_restaurant_app/widgets/list_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/styles.dart';

class RestaurantSearch extends StatefulWidget {
  @override
  _RestaurantSearchState createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {
  String query;

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Restaurant"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FormSearch(
              onSearch: (q) {
                setState(() {
                  query = q;
                });
              },
            ),
            query == null
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: primaryColor,
                          size: 150,
                        ),
                        Text(
                          "Data Not Found",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : FutureBuilder(
                    future: api.listRestaurants(query: query),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        if (snapshot.data.restaurants.length != 0) {
                          return Expanded(
                              child: ListRestaurant(
                                  restaurants: snapshot.data.restaurants));
                        } else {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: primaryColor,
                                  size: 150,
                                ),
                                Text(
                                  "Data Not Found",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      print("Error retrieve: ${snapshot.error}");
                      return Center(
                        child: Text("Connection Error, please try again."),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
