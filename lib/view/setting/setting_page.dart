import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/scheduling_provider.dart';
import 'package:news_app/widgets/custom_dialog.dart';
import 'package:news_app/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Settings"),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text("Dark Theme"),
            trailing: Switch.adaptive(
              value: false,
              onChanged: (value) => customDialog(context),
            ),
          ),
        ),
        Material(
          child: ListTile(
            title: const Text("Scheduling News"),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, schedule, child) {
                return Switch.adaptive(
                  value: schedule.isSchedule,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      schedule.scheduleNews(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
