import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_list.dart';
import 'package:restaurant_app/utils/database_helper.dart';

import '../utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  // late ResultState _state;
  var _state = ResultState.loading;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  List<Restaurant> _favoriteRestaurant = [];

  List<Restaurant> get favorite => _favoriteRestaurant;

  void _getFavorite() async {
    _favoriteRestaurant = await databaseHelper.getFavorite();
    if (_favoriteRestaurant.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertData(restaurant);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
