import 'package:flutter/material.dart';
import 'package:flutter_module/APage.dart';

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// 变量声明 ============================================================================

  // 字体样式
  final TextStyle _listItemHeaderTitleFont =
      const TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0);
  final TextStyle _listItemTitleFont =
      const TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0);

  // 计数器
  int _counter = 0;

  /// 生命周期 ============================================================================

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: _buildAppBar(context), body: _buildBody(context));
  }

  /// 视图布局 ============================================================================

  // 返回导航栏
  Widget _buildAppBar(BuildContext context) {
    return new AppBar(title: new Text("Flutter App"));
  }

  // 返回页面内容
  Widget _buildBody(BuildContext context) {
    return _buildListView(context);
  }

  // 列表
  Widget _buildListView(BuildContext context) {
    return new ListView(children: [
      _buildListViewSectionHeader(context, "UI刷新"),
      _buildListViewIncrementCounterRow(context, 0),
      _buildListViewSectionHeader(context, "页面跳转"),
      _buildListViewGotoAPageRow(context, 0),
      _buildListViewSectionHeader(context, "功能测试"),
      _buildListViewBatteryLevelRow(context, 0),
      _buildListViewMethodChannelDemoRow(context, 0),
    ]);
  }

  // 列表 - 标题行
  Widget _buildListViewSectionHeader(BuildContext context, String title) {
    return _buildListViewHeaderRowWithBottomDivider(
        context, new Text(title, style: _listItemHeaderTitleFont));
  }

  // 列表 - 点击自增行
  Widget _buildListViewIncrementCounterRow(BuildContext context, int index) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0, 5, 0),
      child: new ListTile(
        title: new Text("You have tapped the item $_counter times...",
            style: _listItemTitleFont),
        onTap: _incrementCounter,
      ),
    );
  }

  // 列表 - 测试页跳转
  Widget _buildListViewGotoAPageRow(BuildContext context, int index) {
    return _buildListViewRowWithBottomDivider(
      context,
      new ListTile(
        title: new Text("Goto APage"),
        trailing: new Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new APage(title: 'Flutter A Page');
          }));
        },
      ),
    );
  }

  // 列表 - 电量查询行
  Widget _buildListViewBatteryLevelRow(BuildContext context, int index) {
    return _buildListViewRowWithBottomDivider(
      context,
      new ListTile(
        title: new Text("Goto BatteryLevel Page", style: _listItemTitleFont),
        trailing: new Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(context, "/BatteryLevel");
        },
      ),
    );
  }

  // 列表 - MethodChannel测试
  Widget _buildListViewMethodChannelDemoRow(BuildContext context, int index) {
    return _buildListViewRowWithBottomDivider(
      context,
      new ListTile(
        title:
            new Text("Goto MethodChannelDemo Page", style: _listItemTitleFont),
        trailing: new Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(context, "/MethodChannelDemo");
        },
      ),
    );
  }

  // 返回带有底部分割线的标题行组件
  Widget _buildListViewHeaderRowWithBottomDivider(
      BuildContext context, Widget child) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 20, 5, 5),
          child: child,
        ),
        new Divider(),
      ],
    );
  }

  // 返回带有底部分割线的组件
  Widget _buildListViewRowWithBottomDivider(
      BuildContext context, Widget child) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0, 5, 0),
          child: child,
        ),
        new Divider(),
      ],
    );
  }

  /// 事件处理 ============================================================================

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}

//  // 返回列表
//  Widget buildListView(BuildContext context) {
//    return new ListView.builder(
//      padding: const EdgeInsets.all(16.0),
//      itemBuilder: buildListViewItem,
//    );
//  }
//
//  // 返回列表的Item
//  Widget buildListViewItem(BuildContext context, int index) {
//    // 在每一列之前，添加一个1像素高的分隔线widget
//    if (index.isOdd) return new Divider();
//
//    // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整）
//    return buildItem(context, index ~/ 2);
//  }
//
////  Widget buildItem(BuildContext context, int index) => new Text("xhu_ww", style: _listItemTitleFont);
//
//  Widget buildItem(BuildContext context, int index) {
//
//    return new GestureDetector(
//      onTap: () {
//        //处理点击事件
//        print("aaa");
//      },
//      child: new Container(
//        padding: const EdgeInsets.all(8.0),
//        child: new Text("xhu_ww", style: _listItemTitleFont),
//      ),
//    );
//  }
