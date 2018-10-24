import 'dart:async';

import 'package:flutter/services.dart';

class BatteryLevel {
  static const MethodChannel _channel = const MethodChannel('battery_level');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<int> get batteryLevel async {
    final int level = await _channel.invokeMethod('getBatteryLevel');
    return level;
  }

  static Future<String> get batteryLevelString async {
    return "当前电量：${BatteryLevel.batteryLevel} %.";
  }
}
