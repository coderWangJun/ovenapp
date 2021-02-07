import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text('我的'),
        // ),
        body: new SafeArea(
          child: new Column(children: <Widget>[
            new RaisedButton(
              child: new Text('注册'),
              onPressed: () {
                print("ap => Navigator.push(context,new MaterialPageRoute(builder: (context) => new MySetPage()),);");
                // Navigator.of(context).pushReplacementNamed("/Login");
                Navigator.pop(context);
              },
            ),

            new RaisedButton(
              child: new Text('取消'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]),
        ));
  }
}
