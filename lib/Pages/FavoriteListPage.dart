import 'package:flutter/material.dart';
import 'package:ovenapp/Publics/AppStyle.dart';

class FavoriteListPage extends StatefulWidget {
  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppStyle.mainBackgroundColor,
        title: Text('收藏列表'),
        // actions: _getActions(),
      ),
      body: Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          '您还没有收藏任何内容哦~~~',
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
}