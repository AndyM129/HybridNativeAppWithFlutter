import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelDemoPage extends StatefulWidget {
  MethodChannelDemoPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MethodChannelDemoPageState createState() => new _MethodChannelDemoPageState();
}

class _MethodChannelDemoPageState extends State<MethodChannelDemoPage> {

  // 创建一个给native的channel (类似iOS的通知）
  static const methodChannel = const MethodChannel('com.pages.your/native_get');

//  dynamic bool isHybrid = await MethodChannel('com.pages.your/native_get').invokeMethod('toNativePush','');

  int _counter = 0;
  bool _isHybrid = false;

  @override
  void initState() {
    super.initState();
    updateHybridState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> updateHybridState() async {
    bool isHybrid;
    try {
      isHybrid = await methodChannel.invokeMethod('isHybrid','');
    } on PlatformException {
      isHybrid = false;
    }


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isHybrid = isHybrid;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;

      print('flutter的log打印：现在输出count=$_counter');
      // 当个数累积到3的时候给客户端发参数
      if(_counter == 3) {
        _toNativeSomethingAndGetInfo();
      }

      // 当个数累积到5的时候给客户端发参数
      if(_counter == 1002) {
        Map<String, String> map = { "title": "这是一条来自flutter的参数" };
        methodChannel.invokeMethod('toNativePush',map);
      }

      // 当个数累积到8的时候给客户端发参数
      if(_counter == 1005) {
        Map<String, dynamic> map = { "content": "flutterPop回来","data":[1,2,3,4,5]};
        methodChannel.invokeMethod('toNativePop',map);
      }
    });
  }

  // 是否为混合开发
//  Future<bool> isHybrid() async {
//    dynamic isHybrid;
//    try {
//      isHybrid = await methodChannel.invokeMethod('isHybrid','');
//    } on PlatformException {
//      isHybrid = false;
//    }
//    return isHybrid;
//  }

  // 给客户端发送一些东东 , 并且拿到一些东东
  Future<Null> _toNativeSomethingAndGetInfo() async {
    dynamic result;
    try {
      result = await methodChannel.invokeMethod('toNativeSomething','大佬你点击了$_counter下');
    } on PlatformException {
      result = 100000;
    }
    setState(() {
      // 类型判断
      if (result is int) {
        _counter = result;
      }

    });
  }

  Widget buildBody(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            '当前是否为 Flutter&Native 混合开发：$_isHybrid .',
          ),
          new Text(
            '---You have pushed the button this many times:',
          ),
          new Text(
            '$_counter',
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
//      appBar: new AppBar(
//        // Here we take the value from the MethodChannelDemoPage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: new Text(widget.title),
//      ),
      body: buildBody(context),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
