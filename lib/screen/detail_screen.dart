import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/utils/api_service.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/utils/custom_scroll.dart';

import '../utils/result_state.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';

  final String id;

  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
        create: (_) => DetailProvider(apiService: ApiService(), id: widget.id),
        child: Consumer<DetailProvider>(builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Material(
                child: Center(child: CircularProgressIndicator(color: Colors.blue)));
          } else if (state.state == ResultState.hasData) {
            var data = state.result.restaurant;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.network(
                            "https://restaurant-api.dicoding.dev/images/medium/${data.pictureId}", fit: BoxFit.fill),
                        const SafeArea(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        data.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 26.0,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        data.city,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Oxygen',
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Rating ${data.rating}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        data.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Oxygen',
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: const Text(
                          "Makanan",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.bold),
                        )),
                    ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: SizedBox(
                          height: 50,
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.menus.foods.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.only(
                                        left: 3, right: 3),
                                    child: Chip(
                                      label: Text(data.menus.foods[index].name),
                                    ));
                              },
                            ),
                          )),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: const Text(
                          "Minuman",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.bold),
                        )),
                    ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: SizedBox(
                          height: 50,
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.menus.drinks.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.only(
                                        left: 3, right: 3),
                                    child: Chip(
                                      label:
                                          Text(data.menus.drinks[index].name),
                                    ));
                              },
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.noData) {
            return widgetMessage(context, state.message);
          } else if (state.state == ResultState.error) {
            return widgetMessage(context, state.message);
          } else {
            return const Material(child: Text(''));
          }
        }));
  }

  Widget widgetMessage(BuildContext context, String message) {
    return Material(
      child: Center(
        child: Text(message),
      ),
    );
  }
}
