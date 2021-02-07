import 'package:flutter/material.dart';
import 'package:ovenapp/Publics/AppStyle.dart';

class MyChatPage extends StatefulWidget {
  @override
  _MyChatPageState createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppStyle.mainBackgroundColor,
        title: Text('我的心得'),
        actions: _getActions(),
      ),
      body: Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          '您还没有撰写任何心得记录哦~~~',
          style: TextStyle(
            fontFamily: AppStyle.ffPF,
            fontSize: 18.5,
            color: Colors.grey,
          ),
        ),
      ),
      // _getBodyUI(),
      // Refresh(
      //   onFooterRefresh: onFooterRefresh,
      //   onHeaderRefresh: onHeaderRefresh,
      //   child: _getBodyUI(),
      //   //ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder),
      // ), //_getRefreshUI(), //_getTemplateListFB(),
    );
  }

  List<Widget> _getActions() {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          color: AppStyle.clButtonGray,
          iconSize: 28.0,
          onPressed: () {
            _addChat();
          }),      
    ];
  }

  _addChat(){

  }
}