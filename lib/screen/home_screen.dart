import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screen/detail_screen.dart';
import 'package:restaurant_app/screen/favorite_screen.dart';
import 'package:restaurant_app/screen/settings_page.dart';
import 'package:restaurant_app/widgets/card_list.dart';
import 'package:restaurant_app/utils/custom_scroll.dart';
import 'package:restaurant_app/provider/home_provider.dart';
import 'package:restaurant_app/utils/platform_widget.dart';
import 'package:restaurant_app/screen/search_screen.dart';

import '../utils/notification_helper.dart';
import '../utils/result_state.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  Widget _buildList(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator(color: Colors.blue));
      } else if (state.state == ResultState.hasData) {
        return ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurantList = state.result.restaurants[index];
                return CardList(list: restaurantList);
              },
            ));
      } else if (state.state == ResultState.noData) {
        return widgetMessage(context, state.message);
      } else if (state.state == ResultState.error) {
        return widgetMessage(context, state.message);
      } else {
        return const Material(child: Text(''));
      }
    });
  }

  Widget widgetMessage(BuildContext context, String message) {
    return Center(
      child: Material(
        child: Text(message),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Restaurant App', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const FavoriteScreen()));
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SettingsPage()));
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, SearchScreen.routeName);
        },
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
