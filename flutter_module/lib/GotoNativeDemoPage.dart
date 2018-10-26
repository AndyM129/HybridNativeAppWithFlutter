import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GotoNativeDemoPage extends StatefulWidget {
  GotoNativeDemoPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _GotoNativeDemoPageState createState() => new _GotoNativeDemoPageState();
}

class _GotoNativeDemoPageState extends State<GotoNativeDemoPage> {

  // 创建一个给native的channel (类似iOS的通知）
  static const methodChannel = const MethodChannel('com.pages.your/native_get');

  bool _isHybrid = false;

  @override
  void initState() {
    super.initState();
    updateHybridState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    if (_isHybrid) {
      return null;
    } else {
      return new AppBar(
        // Here we take the value from the GotoNativeDemoPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      );
    }
  }

  Widget buildBody(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
              onPressed: () {
                methodChannel.invokeMethod('toNativePop','我是参数');
              },
              color: Colors.blue,
              child: new Text('Goto Previous Page',
                  style: new TextStyle(color: Colors.white))),
          new RaisedButton(
              onPressed: () {
                methodChannel.invokeMethod('toNativePush', {'initialRoute':'/GotoNativeDemoPage'});
              },
              color: Colors.blue,
              child: new Text('Goto Next Native Page',
                  style: new TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> updateHybridState() async {
    bool isHybrid = false;
    try {
      isHybrid = await methodChannel.invokeMethod('isHybrid','');
    } on PlatformException {
      isHybrid = false;
    }

    setState(() {
      _isHybrid = isHybrid;
    });
  }

}
