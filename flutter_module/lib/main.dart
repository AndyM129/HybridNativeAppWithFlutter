import 'package:flutter/material.dart';
import 'package:flutter_module/MyHomePage.dart';
import 'package:flutter_module/BatteryLevelPage.dart';
import 'package:flutter_module/MethodChannelDemoPage.dart';
import 'package:flutter_module/APage.dart';
import 'package:flutter_module/BPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'ABC Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => MyHomePage(title: 'MyHomePage'),
        '/BatteryLevel': (BuildContext context) => BatteryLevelPage(title: 'BatteryLevelPage'),
        '/MethodChannelDemo': (BuildContext context) => MethodChannelDemoPage(title: 'MethodChannelDemoPage'),
        '/A': (BuildContext context) => APage(title: 'APage'),
        '/B': (BuildContext context) => BPage(title: 'BPage'),
      },
    );
  }
}
