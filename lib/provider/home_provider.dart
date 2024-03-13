import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/api_service.dart';
import 'package:restaurant_app/model/restaurant_list.dart';
import 'package:http/http.dart' as http;

import '../utils/result_state.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService apiService;

  HomeProvider({required this.apiService}) {
    getData();
  }

  late RestaurantList _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantList get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> getData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await apiService.getRestaurantLists(http.Client());
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurantList;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No internet connection';
    }
  }
}
