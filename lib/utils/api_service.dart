import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/detail_restaurant_list.dart';
import 'package:restaurant_app/model/restaurant_list.dart';
import 'package:restaurant_app/model/search_list.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> getRestaurantLists(http.Client client) async {
    final response = await client.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DetailRestaurantList> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<SearchList> searchRestaurant(String name) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$name"));
    if (response.statusCode == 200) {
      return SearchList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}