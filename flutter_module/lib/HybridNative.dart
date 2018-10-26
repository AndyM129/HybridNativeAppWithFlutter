import 'package:flutter/services.dart';

class HybridNative {

  static HybridNative _instance;

  static HybridNative get instance => _getInstance();

  static bool get isHybrid => _isHybrid;

  static bool _isHybrid;

  static const methodChannel = const MethodChannel('com.pages.your/native_get');

  factory HybridNative() =>_getInstance();

  // 初始化
  HybridNative._internal() {
    updateHybridState();
  }

  static HybridNative _getInstance() {
    if (_instance == null) {
      _instance = new HybridNative._internal();
    }
    return _instance;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> updateHybridState() async {
//    try {
//      isHybrid = await methodChannel.invokeMethod('isHybrid','');
//    } on PlatformException {
//      isHybrid = false;
//    }
  }

}