import 'package:flutter/material.dart';
import 'package:flutter_module/NextPage.dart';

class BPage extends StatefulWidget {
  final String title;

  BPage({Key key, this.title}) : super(key: key);

  @override
  _BPageState createState() => new _BPageState();
}

class _BPageState extends State<BPage> {
  String _routeParams;

  void gotoBPage() {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new NextPage(title: 'Flutter Next Page');
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
                onPressed: gotoBPage,
                color: Colors.blue,
                child: new Text('Goto Next Page',
                    style: new TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
