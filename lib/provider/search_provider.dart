import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/api_service.dart';
import 'package:restaurant_app/model/search_list.dart';

import '../utils/result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  late String query;

  SearchProvider({required this.apiService, required this.query}) {
    searchRestaurant(query);
  }

  late SearchList _searchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  SearchList get result => _searchResult;

  ResultState get state => _state;

  Future<dynamic> searchRestaurant(String name) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await apiService.searchRestaurant(name);
      if (data.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = data;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No internet connection';
    }
  }
}