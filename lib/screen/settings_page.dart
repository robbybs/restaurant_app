import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/provider/settings_provider.dart';
import 'package:restaurant_app/widgets/custom_dialog.dart';

import '../utils/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({super.key});

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(settingsTitle, style: TextStyle(color: Colors.white)),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, provider, child) {
      return ListTile(
        title: const Text('Scheduling Restaurant'),
        trailing: Consumer<SchedulingProvider>(
          builder: (context, scheduled, _) {
            return Switch.adaptive(
              value: provider.notificationSwitchCondition,
              onChanged: (value) async {
                if (Platform.isIOS) {
                  customDialog(context);
                } else {
                  scheduled.scheduledRestaurant(value);
                  provider.changeNotificationSwitchCondition(value);
                }
              },
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
