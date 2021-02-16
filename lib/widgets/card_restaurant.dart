import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final Function onPressed;
  const CardRestaurant(
      {Key key, @required this.restaurant, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
              ApiService.mediumImage + restaurant.pictureId,
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
}
