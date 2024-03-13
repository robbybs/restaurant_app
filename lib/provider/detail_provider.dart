import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant_list.dart';

import '../utils/result_state.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;

  final String id;

  DetailProvider({required this.apiService, required this.id}) {
    getData();
  }

  late DetailRestaurantList _detailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurantList get result => _detailResult;

  ResultState get state => _state;

  Future<dynamic> getData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await apiService.getDetailRestaurant(id);
      if (data.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResult = data;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No internet connection';
      // return _message = 'Error: $e';
    }
  }
}
