import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:battery_level/battery_level.dart';

class BatteryLevelPage extends StatefulWidget {
  BatteryLevelPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BatteryLevelPageState createState() => new _BatteryLevelPageState();
}

class _BatteryLevelPageState extends State<BatteryLevelPage> {

  String _platformVersion = 'Unknown';
  int _batteryLevel = 0;

  @override
  void initState() {
    super.initState();
    updatePlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> updatePlatformState() async {
    String platformVersion;

    try {
      platformVersion = await BatteryLevel.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> updateBatteryLevel () async {
    int batteryLevel;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      batteryLevel = await BatteryLevel.batteryLevel;
    } on PlatformException {
      batteryLevel = -1;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text('当前系统版本: $_platformVersion'),
                onPressed: updatePlatformState,
              ),
              RaisedButton(
                child: Text('当前电量: $_batteryLevel %'),
                onPressed: updateBatteryLevel,
              ),
              Text('\n\n（点击按钮以更新信息）'),
            ],
          ),
        ),
      ),
    );
  }
}