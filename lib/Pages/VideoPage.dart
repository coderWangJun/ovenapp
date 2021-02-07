import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/Controls/AppWidget.dart';

import 'package:ovenapp/Pages/AttentionPage.dart';
import 'package:ovenapp/Pages/CameraPage.dart';
import 'package:ovenapp/Pages/HotPushPage.dart';
import 'package:ovenapp/Pages/LiveShowPage.dart';
import 'package:ovenapp/Pages/VideoListPage.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Pages/VideoPlayerPage.dart';

// import 'package:ovenapp/Publics/AppStyle.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  var _scaffoldkey = GlobalKey<ScaffoldState>();  

  Map<String, Widget> _mpTabBar = {
    '关注': AttentionPage(),
    '视频': VideoListPage(),
    '直播': LiveShowPage(),
    '热推': HotPushPage()
  };

  List<Tab> _lstTab = [];
  List<Widget> _lstPage = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _mpTabBar.length, initialIndex: 1, vsync: this);

    _initTab();
    // _mpTabBar.keys.toList().forEach((name) {
    //   _lstTab.add(Tab(
    //     text: name,
    //   ));
    // });

    // _controller.addListener(() {
    //   // print(
    //   //     "@@@ => VideoPage._controller.Listener() _controller.position.pixels : ${_controller.position.pixels} ");
    //   if (_controller.position.pixels > 300 && _dFABHeight == 0.0) {
    //     _dFABHeight = 40.0;
    //     _streamController.sink.add(_dFABHeight);
    //   } else if (_controller.position.pixels < 300 && _dFABHeight == 40.0) {
    //     _dFABHeight = 0.0;
    //     _streamController.sink.add(_dFABHeight);
    //   }
    // });

    print("@@@ => VideoPage.initState() ... ");
  }

  _initTab() {
    _lstTab.clear();
    _lstPage.clear();

    _mpTabBar.forEach((k, v) {
      _lstTab.add(Tab(
        // text: k,
        child: UnconstrainedBox(
          child: Text(
            k,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ));

      _lstPage.add(v);
    });
  }
  // String _avatarFile =
  //     '/storage/emulated/0/Android/data/com.example.ovenapp/files/20200405123402987526.jpg'; //img_1586067460424.jpg';

  @override
  void dispose() {
    super.dispose();
    // _onPageDataEvent.cancel();
    // _controller.dispose();
    // _streamController.close();
    print("@@@ VideoPage.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ VideoPage.build() ...");
// GlobalVar.getScreenSize(context,'VideoPage');
    // _avatarFile =
    //     '/storage/emulated/0/Android/data/com.example.ovenapp/files/20200406122813595595.jpg';
    return Scaffold(
      key: _scaffoldkey,
      // appBar: AppBar(
      //   primary: false,
      //   titleSpacing: 0.0,
      //   // leading: null,
      //   // title: Text('视频直播'),
      //   // title: AppWidget.getSearcherTF('产品关键字', (tn, v) {
      //   //   print('@@@ tn : $tn , v : $v');
      //   // }), //getSeacherTF(), //_getSearchTextField(),
      //   // actions: _getActions(),
      //   // backgroundColor: AppStyle.clTitleBC,
      //   // bottom: TabBar(
      //   //   tabs: _lstTab,
      //   //   controller: _tabController,
      //   // ),
      // ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                // color: Colors.deepOrangeAccent,
                border: Border(
                  //   left: BorderSide(
                  //       color: Colors.purpleAccent, width: 5.0, style: BorderStyle.solid),
                  //   top: BorderSide(
                  //       color: Colors.purpleAccent, width: 1.0, style: BorderStyle.solid),
                  //   right: BorderSide(
                  //       color: Colors.purpleAccent, width: 1.0, style: BorderStyle.solid),
                  bottom: BorderSide(
                      color: Colors.grey[300],
                      width: 1.0,
                      style: BorderStyle.solid),
                  // ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  //头像
                  AppWidget.getBroadContainer(
                      IconButton(
                          icon: Image.asset(
                            'images/header.png',
                            color: Colors.redAccent,
                            height: 20.0,
                            width: 20.0,
                          ),
                          padding: EdgeInsets.zero,
                          iconSize: 24.0,
                          onPressed: () {
                            print('@@@ Record ...');
                          }),
                      32.0,
                      32.0,
                      16.0,
                      Colors.redAccent,
                      EdgeInsets.only(left: 8.0, right: 5.0)),
                  // Container(
                  //   // margin: EdgeInsets.only(
                  //   //   left: 3.0,
                  //   //   right: 3.0,
                  //   // ),
                  //   child: IconButton(
                  //       icon: Image.asset(
                  //         'images/header.png',
                  //         color: Colors.redAccent,
                  //         height: 24.0,
                  //         width: 24.0,
                  //       ),
                  //       padding: EdgeInsets.zero,
                  //       iconSize: 24.0,
                  //       onPressed: () {
                  //         print('@@@ Record ...');
                  //       }),
                  // ),

                  // Container(
                  //   margin: EdgeInsets.only(
                  //     left: 5.0,
                  //     right: 5.0,
                  //   ),
                  //   child: Image.asset(
                  //     'images/header.png',
                  //     color: Colors.redAccent,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  // ),
                  //导航
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      // height: 50.0,
                      // width: double.infinity,
                      // color: Colors.redAccent,
                      child: TabBar(
                        unselectedLabelColor: Colors.black38,
                        labelColor: Colors.teal,
                        indicatorColor: Colors.teal,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3.0,
                        tabs: _lstTab,
                        controller: _tabController,
                      ),
                    ),
                  ),

                  //录像
                  AppWidget.getBroadContainer(
                      IconButton(
                          icon: Icon(
                            Icons.videocam,
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.zero,
                          iconSize: 24.0,
                          onPressed: () {
                            print('@@@ Record ...');
                            _openCamera();
                          }),
                      32.0,
                      32.0,
                      16.0,
                      Colors.blueAccent,
                      EdgeInsets.only(left: 5.0, right: 8.0)),

                  // Container(
                  //   margin: EdgeInsets.only(
                  //     left: 5.0,
                  //     right: 5.0,
                  //   ),
                  //   child: IconButton(
                  //       icon: Icon(
                  //         Icons.videocam,
                  //         color: Colors.blue,
                  //       ),
                  //       padding: EdgeInsets.zero,
                  //       iconSize: 30.0,
                  //       onPressed: () {
                  //         print('@@@ Record ...');
                  //       }),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _lstPage,
              ),
            ),
          ],
        ),
      ),

      // SafeArea(

      //     child: Column(
      //       children: <Widget>[
      //         AppWidget.getFullWidthButton(context, '播放视频', Colors.green, () {
      //           _playVideo('v1.mp4');
      //         },
      //             EdgeInsets.only(
      //               bottom: 15.0,
      //             )),
      //         AppWidget.getFullWidthButton(context, '播放视频', Colors.green, () {
      //           _playVideo('v2.mp4');
      //         },
      //             EdgeInsets.only(
      //               bottom: 15.0,
      //             )),
      //         AppWidget.getFullWidthButton(context, '播放视频', Colors.green, () {
      //           _playVideo('v3.mp4');
      //         },
      //             EdgeInsets.only(
      //               bottom: 15.0,
      //             )),
      //       ],
      //     )),
    );
  }

  _openCamera() async {
    // var image = await ImagePicker.pickImage(source: ImageSource.camera);
    // if (image == null) {
    //   print('@@@ image is null');
    // } else {
    //   print('@@@ image : ${File(image.path).lengthSync()}');
    // }
       Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CameraPage(),
      ),
    );
  }
  // _playVideo(vf) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           VideoPlayerPage(vfile: 'https://www.cfdzkj.com:811/webimages/$vf'),
  //     ),
  //   );
  // }

  // _scrollTo(offset) {
  //   //  _controller.jumpTo(_controller.position.maxScrollExtent);
  //   // _controller.jumpTo(_controller.position.minScrollExtent);
  //   _controller.animateTo(
  //     offset,
  //     // _controller.position.minScrollExtent,
  //     duration: Duration(milliseconds: 600), // 300ms
  //     curve: Curves.bounceIn, // 动画方式
  //   );
  // }

  // _popMenu(context) {
  //   // RenderBox box = context.findRenderObject();
  //   // Offset offset = box.localToGlobal(Offset.zero);
  //   // Size size = box.size;
  //   // double l = offset.dx + size.width / 4;
  //   // double t = offset.dy + size.height / 3;
  //   double dTop = MediaQueryData.fromWindow(window).padding.top + 56.0;
  //   print("_popMenu() dTop : $dTop");
  //   showMenu(
  //     context: context,
  //     position: RelativeRect.fromLTRB(1000.0, dTop, 0.0, 0.0),
  //     items: <PopupMenuItem<String>>[
  //       PopupMenuItem(value: "0", child: new Text("全部")),
  //       PopupMenuItem(value: "1", child: Text("模板")),
  //       PopupMenuItem(value: "2", child: Text("心得")),
  //     ],
  //     // items: <PopupMenuEntry>[
  //     //   PopupMenuItem(value: "0", child: Text("移除")),
  //     //   PopupMenuDivider(),
  //     // ],
  //   ).then((v) {
  //     // print("selected : $v");
  //     if (v == "0") {
  //       print("position ：${_controller.position.pixels}");
  //       // _streamController.sink.add(_controller.position.pixels);
  //     }
  //     if (v == "1") {
  //       print("position ：${_controller.position.pixels}");
  //       // _streamController.sink.add(_controller.position.pixels);
  //     }
  //   });
  // }
}
