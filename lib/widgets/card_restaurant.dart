import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final Function onPressed;
  const CardRestaurant(
      {Key key, @required this.restaurant, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return GestureDetector(
              onTap: onPressed,
              child: Card(
                elevation: 5.0,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.all(5),
                child: GridTile(
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      ApiService.smallImage + restaurant.pictureId,
                      fit: BoxFit.cover,
                    ),
                  ),
                  header: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: isFavorite
                              ? IconButton(
                                  icon: Icon(Icons.favorite),
                                  color: Colors.red,
                                  onPressed: () => provider.removeFavorite(
                                      restaurant, context),
                                )
                              : IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  color: Colors.red,
                                  onPressed: () =>
                                      provider.addFavorite(restaurant, context),
                                ),
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
                              size: 15.0,
                            ),
                            Text(
                              restaurant.city,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: restaurant.rating.toDouble(),
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
                              restaurant.rating.toString(),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[900],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
