import 'package:dicoding_restaurant_app/data/model/detail_restaurant_result.dart';
import 'package:dicoding_restaurant_app/data/model/search_restaurant_result.dart';

import '../data/api/api_service.dart';
import '../data/model/list_restaurant_result.dart';
import '../utils/result_state.dart';

import 'package:flutter/cupertino.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({@required this.apiService}) {
    getRestaurants();
  }

  ResultState _state;
  ResultState get state => _state;

  ResultState _stateDetail;
  ResultState get stateDetail => _stateDetail;

  ResultState _stateSearch;
  ResultState get stateSearch => _stateSearch;

  String _message = '';
  String get message => _message;

  ListRestaurantResult _listRestaurantResult;
  ListRestaurantResult get result => _listRestaurantResult;

  DetailRestaurantResult _detailRestaurant;
  DetailRestaurantResult get resultDetailRestaurant => _detailRestaurant;

  SearchRestaurantResult _searchRestaurantResult;
  SearchRestaurantResult get resultSearchRestaurants => _searchRestaurantResult;

  void getRestaurants() {
    _doCall();
  }

  void getRestaurantsById(String id) {
    _doCall(id: id);
  }

  void getRestaurantsByQuery(String query) {
    _doCall(query: query);
  }

  void _doCall({String id = "", String query = ""}) {
    Future<dynamic> result;
    if ((id.isEmpty) && (query.isEmpty)) {
      result = _getListRestaurants();
    } else if (id.isNotEmpty) {
      result = _getDetailRestaurant(id);
    } else if (query.isNotEmpty) {
      result = _getSearchListRestaurants(query);
    }

    result.then((value) {
      if (id.isEmpty && query.isEmpty) {
        _listRestaurantResult = value;
      } else if (id.isNotEmpty) {
        _detailRestaurant = value;
      } else if (query.isNotEmpty) {
        _searchRestaurantResult = value;
      }
    });
  }

  Future<dynamic> _getListRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final restaurants = await apiService.listRestaurants();

      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error = $e';
    }
  }

  Future<dynamic> _getDetailRestaurant(String id) async {
    try {
      _stateDetail = ResultState.Loading;
      notifyListeners();

      final restaurant = await apiService.detailRestaurant(id);

      if (restaurant == null) {
        _stateDetail = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _stateDetail = ResultState.HasData;
        notifyListeners();
        return restaurant;
      }
    } catch (e) {
      _stateDetail = ResultState.Error;
      notifyListeners();
      return _message = 'Error = $e';
    }
  }

  Future<dynamic> _getSearchListRestaurants(String query) async {
    try {
      _stateSearch = ResultState.Loading;
      notifyListeners();

      final restaurants = await apiService.listRestaurants(query: query);

      if (restaurants.restaurants.isEmpty) {
        _stateSearch = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _stateSearch = ResultState.HasData;
        notifyListeners();
        return restaurants;
      }
    } catch (e) {
      _stateSearch = ResultState.Error;
      notifyListeners();
      return _message = 'Error = $e';
    }
  }
}
