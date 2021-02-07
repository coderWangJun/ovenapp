import 'package:flutter/material.dart';
import 'package:ovenapp/Controls/AppImage.dart';
import 'package:ovenapp/Models/MaterialModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class MaterialDetailPage extends StatefulWidget {
  MaterialDetailPage({Key key, this.materialModel}) : super(key: key);
  final MaterialModel materialModel;

  @override
  _MaterialDetailPageState createState() => _MaterialDetailPageState();
}

class _MaterialDetailPageState extends State<MaterialDetailPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey _appBarKey = new GlobalKey();

  double dImageWidth = GlobalVar.dScreenWidth;
  double dImageHeight = 320.0;
  double dImageRadius = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            //headerSliverBuilder子控件开始
            // _getHeaderWidget(),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                key: _appBarKey,
                elevation: 0.0,
                backgroundColor: AppStyle.clTitleBC, // Colors.grey[100],
                // backgroundColor: Colors.transparent,
                leading: new IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppStyle.clTitle2FC,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(widget.materialModel.name),
                // actions: _getActions(),
                primary: true,
                //  brightness: Brightness.dark,
                titleSpacing: NavigationToolbar.kMiddleSpacing,
                textTheme: TextTheme(
                    button:
                        TextStyle(color: Colors.red, fontSize: 18.0)), //字体样式
                centerTitle: true,
                automaticallyImplyLeading: false,
                // floating: false,
                // snap:false,
                //       flexibleSpace: new FlexibleSpaceBar(
                //   title: new Text("随内容一起滑动的头部"),
                //   centerTitle: true,
                //   collapseMode: CollapseMode.pin,
                // ),
                pinned: true, //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
                forceElevated: innerBoxIsScrolled,
                expandedHeight: 320.0, //展开高度200
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  // title:Text('低档模板烤糊吐司'),
                  // title: Container(alignment: Alignment.bottomCenter,
                  //   height: 45.0,color: Colors.yellowAccent[100],),
                  // Text('我是一个FlexibleSpaceBar'), //_getHeaderWidget(),//
                  background: Container(
                    // color: AppStyle.clTitleBC,// Colors.black12,
                    color: Colors.transparent,
                    child: _getFlexibleHeader(),
                    padding: EdgeInsets.only(top: 80.0),
                    //RaisedButton(onPressed: (){},child: Text('Yesterday Once More ...'),),
                  ),
                ),

// bottom:   此处必须是 PreferredSizeWidget 的子类才行，即各种Bar ，去掉此处便能实现隐藏header保存子页滑动的效果

                // actions: <Widget>[
                //   IconButton(icon: Icon(Icons.add_circle), onPressed: null),
                // ],
              ),
            ),

            // SliverPersistentHeader(
            //   floating: false,
            //   pinned: true,
            //   delegate: _SliverWidgetDelegate(
            //     _getTabBarUI(TemplateBO.index),
            //   ),
            //   // Tab(icon: Icon(Icons.golf_course), text: '右侧'),
            // ),

            // SliverPersistentHeader(
            //   floating: false,
            //   pinned: true,
            //   delegate: _SliverSpaceDelegate(
            //     Container(
            //       // margin: EdgeInsets.only(bottom: TemplateParam.dTitleHeight,),
            //       height: TemplateParam.dSpaceHeight,
            //     ),
            //   ),
            // ),

            // SliverFixedExtentList(
            //   itemExtent: 50.0,
            //   delegate: new SliverChildBuilderDelegate(
            //     (context, index) => new ListTile(
            //       title: new Text("Item $index"),
            //     ),
            //     childCount: 30,
            //   ),
            // ),
            //保留区
            // SliverPersistentHeader(
            //     delegate: _SliverAppBarDelegate(TabBar(
            //   labelColor: Colors.red,
            //   unselectedLabelColor: Colors.grey,
            //   tabs: _lstTabs,
            //   controller: TabController(length: 3, vsync: this),
            // ))),

            //headerSliverBuilder子控件结束
          ];
        },
        body: SafeArea(
          top: true,
          bottom: true,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: _getListViewUI(),
            ),
            // ListView.builder(
            //   itemBuilder: _itemBuilder,
            //   itemCount: 15,
            // ),
          ),
        ),

        // _getSectionList(),
        // TabBarView(
        //   controller: _tabController,
        //   children: _lstTabView,
        //   // myTabs.map((title) {
        //   //   return mapTabPage[title];
        //   // }).toList(),
        // ),
      ),
      // bottomNavigationBar: _getBottomButtons(),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: 'templateadd',
      //   backgroundColor: Colors.blueAccent,
      //   child: Icon(
      //     _getIconData(), //Icons.add,
      //     size: 30.0,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     _showEditor();
      //   },
      // ),
    );
  }

  Widget _getFlexibleHeader() {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      //padding: EdgeInsets.all(0.0),
      height: 256.0,
      // width: 160.0,
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          //子控件开始

          //左边图片
          GestureDetector(
            child:
                // _getHeaderPic(),
                Padding(
              padding: EdgeInsets.all(0.0),
              child: _getHeaderPic(),
            ),
            onTap: () {
              // _loadImage(context);
            },
          ),

          //子控件结束
        ],
      ),
    );
  }

  _getListViewUI() {
    return Text(
      widget.materialModel.memo,
      style: TextStyle(
        fontSize: 18.0,
        color: AppStyle.clTitle2FC,
      ),
      textAlign: TextAlign.left,
      strutStyle: StrutStyle(
        forceStrutHeight: true,
        height: 1.0,
        leading: 0.8,
      ),
    );
  }

  _getHeaderPic() {
    // String imgFile = '';
    // print(
    // '@@@ TemplatePage._getHeaderPic() templateModel.mainpic : ${templateModel.mainpic}');
    if (widget.materialModel.mainpic == null ||
        widget.materialModel.mainpic == '' ||
        widget.materialModel.mainpic == 'camera.png') {
      // return Image.file(File(_localImage), fit: BoxFit.fitWidth);
      Icon icon = Icon(
        Icons.camera_alt,
        color: AppStyle.clBorderImage1,
        size: 48.0,
      );

      // print('@@@ TemplatePage._getHeaderPic() AppImage.rectMaterialIcon : ${templateModel.mainpic}');
      return AppImage.rectMaterialIcon(icon, dImageWidth, dImageHeight,
          dImageRadius, AppStyle.clBorderImage1);
    }

    // if (GlobalVar.platForm == 1) {
    //   // return Image.file(File(_localImage), fit: BoxFit.fitWidth);
    //   return AppImage.rectImage(_localImage, dImageWidth,dImageHeight,dImageRadius,AppStyle.clBorderImage);
    // }

    // if (GlobalVar.platForm == 0 &&
    //     _localImageFile != null &&
    //     _localImageFile != '') {
    //   // print(
    //   //     '@@@ TemplatePage._getHeaderPic() _localImageFile : $_localImageFile');
    //   return AppImage.rectLocalImage(
    //       _localImageFile, dImageWidth, dImageHeight, dImageRadius);
    // }

    // print('@@@ TemplatePage._getHeaderPic() AppImage.rectImage ...');
    return AppImage.rectImage(
        widget.materialModel.mainpic, dImageWidth, dImageHeight, dImageRadius);
    // if (_mainPic == 'camera.png'), AppStyle.clBorderImage
    //   return AppWidget.getAssetImage(_mainPic, 45.0, Colors.grey[400]);

    // return AppWidget.getCachedNetImage(_mainPic);

    // return AppWidget.getBroadContainer(
    //   _getMainpicUI(),
    //   128.0,
    //   170.0,
    //   5.0,
    //   Colors.grey[300],
    //   EdgeInsets.all(10.0),
    // );
  }

  _getActions() {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.refresh),
          color: AppStyle.clTitle2FC,
          iconSize: 28.0,
          onPressed: () {
            _barButtonClick('0');
          }),
      IconButton(
          icon: Icon(Icons.share),
          // color: templateModel.ischare == 1
          //     ? Colors.greenAccent
          //     : AppStyle.clTitle2FC,
          iconSize: 28.0,
          onPressed: () {
            _barButtonClick('2');
          }),
    ];
  }

  _barButtonClick(ct) {
    // print('@@@ ct => $ct');
    // templateModel.memo = '怨在不舍小过，患在不预定谋。福在积善，祸在积恶。${DateTime.now()}';
    // _streamController.sink.add(templateModel);

    switch (ct) {
      case '0': //刷新
        // _refreshData();
        break;
      // case '1': //运行
      //   Navigator.of(context).pop('RUN');
      //   break;
      case '2': //共享
        // _shareTemp();
        // TemplateModel tm = AppPublicData.mpDataModel[spfile] as TemplateModel;
        // print(
        //     '@@@ TemplatePage._barButtonClick() &&&&&&&&&&&&&& TemplateModel : ${tm.toJsonStr()}');
        break;
    }
  }
}
