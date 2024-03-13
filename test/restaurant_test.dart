import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/model/restaurant_list.dart';
import 'package:restaurant_app/utils/api_service.dart';

// import 'restaurant_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  // test('Test get data', () async {
  //   final client = MockClient();
  //
  //   when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
  //       .thenAnswer((_) async => http.Response(
  //           '{"error":false,"message":"success","count":20,"restaurants":[]}',
  //           200));
  //
  //   expect(await getRestaurant(client), isA<RestaurantList>());
  // });
  // test('Test get data', () async {
  //   final client = MockClient();
  //
  //   when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
  //       .thenAnswer((_) async => http.Response(
  //       '{"error":false,"message":"success","count":20,"restaurants":[]}',
  //       200));
  //
  //   expect(await ApiService().getRestaurantLists(client), isA<RestaurantList>());
  // });

  test(
    'for Restaurant List',
        () async {
      final client = MockClient(
            (request) async {
          final response = {
            "error": false,
            "message": "success",
            "count": 20,
            "restaurants": []
          };
          return Response(json.encode(response), 200);
        },
      );

      expect(await ApiService().getRestaurantLists(client), isA<RestaurantList>());
    },
  );
}

Future<RestaurantList> getRestaurant(http.Client client) async {
  final response =
      await http.get(Uri.parse("https://restaurant-api.dicoding.dev/list"));
  if (response.statusCode == 200) {
    return RestaurantList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
