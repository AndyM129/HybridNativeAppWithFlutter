import 'package:flutter/material.dart';
import 'package:flutter_module/BPage.dart';

class APage extends StatefulWidget {
  final String title;

  APage({Key key, this.title}) : super(key: key);

  @override
  _APageState createState() => new _APageState();
}

class _APageState extends State<APage> {
  String _routeParams;

  void gotoAPage() {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new BPage(title: 'Flutter B Page');
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
                onPressed: gotoAPage,
                color: Colors.blue,
                child: new Text('Goto B Page',
                    style: new TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
