import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/navigation.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/provider/settings_provider.dart';
import 'package:restaurant_app/screen/settings_page.dart';
import 'package:restaurant_app/utils/api_service.dart';
import 'package:restaurant_app/screen/detail_screen.dart';
import 'package:restaurant_app/provider/home_provider.dart';
import 'package:restaurant_app/screen/home_screen.dart';
import 'package:restaurant_app/screen/search_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/database_helper.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import 'provider/database_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeProvider>(
              create: (_) => HomeProvider(apiService: ApiService())),
          ChangeNotifierProvider(
              create: (_) =>
                  DatabaseProvider(databaseHelper: DatabaseHelper())),
          ChangeNotifierProvider<SettingsProvider>(
            create: (_) => SettingsProvider(),
            child: const SettingsPage(),
          ),
          ChangeNotifierProvider<SchedulingProvider>(
            create: (context) => SchedulingProvider(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          home: const HomeScreen(),
          routes: {
            DetailScreen.routeName: (context) => DetailScreen(
                id: ModalRoute.of(context)?.settings.arguments as String),
            SearchScreen.routeName: (context) => const SearchScreen()
          },
        ));
  }
}
