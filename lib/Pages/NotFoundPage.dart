import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('错误提示'),
      ),
      body: new Center(
          child: new Text('找不到指定的路由 404！'),
        ),      
    );
  }
}