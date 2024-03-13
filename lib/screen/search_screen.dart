import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/utils/api_service.dart';
import 'package:restaurant_app/widgets/card_search_list.dart';
import 'package:restaurant_app/utils/custom_scroll.dart';
import 'package:restaurant_app/provider/search_provider.dart';

import '../utils/result_state.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  static String query = '';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  bool search = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
        create: (_) => SearchProvider(apiService: ApiService(), query: ''),
        child: Consumer<SearchProvider>(builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Material(
                child: Center(child: CircularProgressIndicator(color: Colors.blue)));
          } else if (state.state == ResultState.hasData) {
            return Material(
                child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: TextField(
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(Radius.circular(8.0))
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0))
                              ),
                              hintText: 'Masukkan nama restoran',
                            ),
                            onSubmitted: (value) {
                              state.searchRestaurant(value);
                              FocusManager.instance.primaryFocus?.unfocus();
                              },
                          ),
                        ),
                        Expanded(
                            child: ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.result.restaurants.length,
                                  itemBuilder: (context, index) {
                                    var restaurantList =
                                    state.result.restaurants[index];
                                    return CardSearchList(list: restaurantList);
                                    },
                                )
                            )
                        ),
                      ],
                    )
                )
            );
          } else if (state.state == ResultState.noData) {
            return widgetMessage(context, state);
          } else if (state.state == ResultState.error) {
            return widgetMessage(context, state);
          } else {
            return const Material(child: Text(''));
          }
        }));
  }

  Widget widgetMessage(BuildContext context, SearchProvider state) {
    return Material(
        child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Masukkan nama restoran',
                    ),
                    onSubmitted: (value) {
                      state.searchRestaurant(value);
                      },
                  ),
                ),
                Center(
                  heightFactor: 5,
                  child: Text(state.message),
                ),
              ],
            )
        )
    );
  }
}
