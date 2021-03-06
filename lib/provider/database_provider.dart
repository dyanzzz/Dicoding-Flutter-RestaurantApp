import 'package:dicoding_restaurant_app/data/db/database_helper.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({@required this.databaseHelper}) {
    _getFavorite();
  }

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  void _getFavorite() async {
    _favorite = await databaseHelper.getFavorite();
    if (_favorite.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant, BuildContext context) async {
    try {
      await databaseHelper.insertFavorite(restaurant);

      Toast.show("I like " + restaurant.name, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error = $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(Restaurant restaurant, BuildContext context) async {
    try {
      await databaseHelper.removeFavorite(restaurant.id);

      Toast.show("I do not like " + restaurant.name, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error = $e';
      notifyListeners();
    }
  }
}
