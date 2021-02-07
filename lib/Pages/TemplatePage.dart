import 'dart:async';
import 'dart:convert';
// import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Classes/FileLoadHelper.dart';
import 'package:ovenapp/Classes/app_dialog_helper.dart';
import 'package:ovenapp/Controls/AppImage.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/DescribeModel.dart';

// import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/RecipeModel.dart';
// import 'package:ovenapp/Models/SectionTimeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Pages/TLDescribeEditPage.dart';
// import 'package:ovenapp/Pages/TLDescribePage.dart';
import 'package:ovenapp/Pages/TLRecipeEditPage.dart';
// import 'package:ovenapp/Pages/TLRecipePage.dart';
import 'package:ovenapp/Pages/TLSectionPage.dart';
import 'package:ovenapp/Pages/TemplateEditPage.dart';
// import 'package:ovenapp/Pages/TimeSectionEditPage.dart';
// import 'package:ovenapp/Publics/AppPublicData.dart';
// import 'package:ovenapp/Publics/AppObjHelper.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/DateTimeHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';
import 'package:ovenapp/Services/HttpCallerSrv.dart';

class TemplatePage extends StatefulWidget {
  TemplatePage({Key key, this.id}) : super(key: key);
  // final TemplateModel templateModel;, this.templateModel
  final int id;
  // final int edittype;, this.edittype
  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey _appBarKey = new GlobalKey();

  // String _localImageFile; //本地文件，中途更换图片时专用，
  double dImageWidth = 170.0;
  double dImageHeight = 128.0;
  double dImageRadius = 5.0;

  List myTabs;
//, child: Text('说明', style:TextStyle(color: Colors.red,fontSize: 18.0),),
  // List<Widget> _lstTabs;

  // List<Widget> _lstTabView;

  TemplateModel templateModel;

  Future fData;

  // StreamBuilder<TemplateModel> _sbTemplateModel;
  // Map<String, dynamic> mapTabPage;

  final StreamController<TemplateModel> _streamController =
      StreamController<TemplateModel>();

  // String spfile;
  var _onTemplateCallEvent;
  // var _tabController;
  // String _localImage;
  // static int _index = 0; //0时段，1配方，2说明
  // String _mainPic = 'camera.png';
  @override
  void initState() {
    super.initState();

    TemplateBO.index = 0;
    // spfile = TemplateBO.getSpfile(
    //     widget.id); // GlobalVar.sptemplate + widget.id.toString();
    // templateModel = AppPublicData.mpDataModel[spfile] as TemplateModel;
    templateModel = GlobalVar.lstTemplate[widget.id];

    // if (templateModel.mainpic != null && templateModel.mainpic != '')
    //   _mainPic = templateModel.mainpic;

    print(
        "@@@ => TemplatePage.initState() ... templateModel ：${templateModel.toJsonStr()} ");

    myTabs = [
      "烘焙时段",
      "原料配方",
      "产品说明",
    ];

    _onTemplateCallEvent = eventBus.on<TemplateCallEvent>().listen((event) {
      if (event.child == 'describetext')
        _addTextDescribe(event.index);
      else if (event.child == 'describeimage') _addImageDescribe(event.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _onTemplateCallEvent.cancel();
    print("@@@ TemplatePage.dispose() ... ${DateTime.now()}");
    // tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "@@@ ${DateTime.now()} => TemplatePage.build() ... id : ${templateModel.id}");

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
                // shape: Border(
                //   bottom: BorderSide(
                //     width: 0.8,
                //     color:
                //         Colors.greenAccent, // AppStyle.clAppBarBottomLineColor,
                //   ),
                // ), //AppWidget.getAppBarBottomBorder(),
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
                title: Text(templateModel.name),
                actions: _getActions(),
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
                expandedHeight: 180.0, //展开高度200
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
                    padding: EdgeInsets.only(top: 70.0), //为标题栏留出的高度
                    // decoration: BoxDecoration(
                    //   color: Colors.transparent,
                    //   border: Border(
                    //     top: BorderSide(color: Colors.redAccent, width: 1.0),
                    //     // bottom: BorderSide(color: TemplateParam.clSplitLine, width: 1.0),
                    //   ), //灰色的一层边框
                    // ),
                    //RaisedButton(onPressed: (){},child: Text('Yesterday Once More ...'),),
                  ),
                ),

// bottom:   此处必须是 PreferredSizeWidget 的子类才行，即各种Bar ，去掉此处便能实现隐藏header保存子页滑动的效果

                // actions: <Widget>[
                //   IconButton(icon: Icon(Icons.add_circle), onPressed: null),
                // ],
              ),
            ),

            SliverPersistentHeader(
              floating: false,
              pinned: true,
              delegate: _SliverWidgetDelegate(
                _getTabBarUI(TemplateBO.index),
              ),
              // Tab(icon: Icon(Icons.golf_course), text: '右侧'),
            ),

            SliverPersistentHeader(
              floating: false,
              pinned: true,
              delegate: _SliverSpaceDelegate(
                Container(
                  // margin: EdgeInsets.only(bottom: TemplateParam.dTitleHeight,),
                  height: TemplateParam.dSpaceHeight,
                ),
              ),
            ),

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
            child: _getListViewUI(),
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
      floatingActionButton: FloatingActionButton(
        heroTag: 'templateadd',
        backgroundColor: Colors.blueAccent,
        child: Icon(
          _getIconData(), //Icons.add,
          size: 30.0,
          color: Colors.white,
        ),
        onPressed: () {
          _showEditor();
        },
      ),
    );
  }

  _getIconData() {
    switch (TemplateBO.index) {
      case 0:
        return Icons.add_alert;
        break;
      case 1:
        return Icons.add_shopping_cart;
        break;
      case 2:
        return Icons.add_comment;
        break;
      default:
    }
  }

  _showEditor() {
    switch (TemplateBO.index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TLSectionPage(id: widget.id)));
        break;
      case 1:
        _addRecipe(0);
        break;
      case 2:
        _addDescribe();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TLDescribePage(id: widget.id)));
        break;
      default:
    }
  }
  //DefaultTabController.of(_scaffoldKey.currentState.context).index;
  //DefaultTabController.of(_scaffoldKey.currentContext).index = 1;
  //但是这种方式会有个奇怪的效果，建议换成如下方式：
  //DefaultTabController.of(_scaffoldKey.currentContext).animateTo(index);

  _getTabBarUI(_index) {
    print('@@@ TemplatePage._getTabBarUI($_index -- ${TemplateBO.index})');
    return Container(
      height: TemplateParam.dTitleHeight,
      // margin: EdgeInsets.only(bottom: TemplateParam.dTitleHeight,),
      decoration: BoxDecoration(
        color: AppStyle.clTitleBC, // Colors.transparent,
        border: Border(
          top: BorderSide(color: TemplateParam.clSplitLine, width: 1.0),
          bottom: BorderSide(color: TemplateParam.clSplitLine, width: 1.0),
        ), //灰色的一层边框
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _getTabUI(0),
          ),
          Container(
            width: 1.0,
            color: TemplateParam.clSplitLine,
            margin: EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
          ),
          Expanded(
            child: _getTabUI(1),
          ),
          Container(
            width: 1.0,
            color: TemplateParam.clSplitLine,
            margin: EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
          ),
          Expanded(
            child: _getTabUI(2),
          ),
        ],
      ),
    );
  }

  _getListViewUI() {
    // print("@@@ TemplatePage._getListViewUI() ... _index : ${TemplateBO.index}");
    switch (TemplateBO.index) {
      case 0:
        return _getSectionListUI();
        break;
      case 1:
        return _getRecipeUI();
        break;
      case 2:
        return _getDescribeUI();
        break;
      default:
        return Text('');
    }
  }

  _getSectionListUI() {
    // List<Widget> _lv = [];
    // _lv.add(SizedBox(
    //   height: TemplateParam.dTitleHeight,
    // ));
    // for (int i = 0; i < 5; i++) {
    //   _lv.add(_getSectionItemUI(i));
    // }
    // return _lv;
    if (templateModel.lstSection == null ||
        templateModel.lstSection.length == 0) return Text('');

    Widget divider1 = Divider(
      indent: 80.0,
      endIndent: 10.0,
      color: Colors.transparent, //.grey[400],
      height: 0.0,
    );
    return ListView.separated(
      // padding: EdgeInsets.all(0.0),
      itemCount: templateModel.lstSection.length,
      itemBuilder: (BuildContext context, int position) {
        return _getSectionItemUI(position);
      },
      separatorBuilder: (BuildContext context, int index) {
        // return index % 2 == 0 ? divider1 : divider2;
        return divider1;
      },
    );
  }

  _getDescribeUI() {
    if (templateModel.lstDescribe == null ||
        templateModel.lstDescribe.length == 0) return Text('');
    Widget divider1 = Divider(
      indent: 80.0,
      endIndent: 10.0,
      color: Colors.transparent, //.grey[400],
      height: 0.0,
    );
    return ListView.separated(
      // padding: EdgeInsets.all(0.0),
      itemCount: templateModel.lstDescribe.length,
      itemBuilder: (BuildContext context, int position) {
        return _getDescribeItemUI(position); //_getSectionItemUI(position);
      },
      separatorBuilder: (BuildContext context, int index) {
        // return index % 2 == 0 ? divider1 : divider2;
        return divider1;
      },
    );
    // return Text('说明');
  }

  _getDescribeItemUI(index) {
    DescribeModel dm = templateModel.lstDescribe[index];
    return Slidable(
      actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
      actionExtentRatio: 0.25,
      // actions: <Widget>[
      //   //左侧按钮列表
      //   IconSlideAction(
      //     caption: '运行',
      //     color: Colors.green,
      //     icon: Icons.play_circle_outline,
      //     onTap: () => _runtTemplate(tm),
      //   ),
      // ],
      secondaryActions: <Widget>[
        //右侧按钮列表
        // IconSlideAction(
        //     caption: 'More',
        //     color: Colors.black45,
        //     icon: Icons.more_horiz,
        //     onTap: () => _showSnackBar('More'),

        // ),
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.clear,
          closeOnTap: false,
          onTap: () {
            AppDialog.showYesNoIOS(context, '删除确认', '您确定要删除该说明项吗？', () {
              _deleteDescribe(dm);
            });
            // _showSnackBar('配方已删除');
          },
        ),
        IconSlideAction(
          caption: '插入',
          color: Colors.green,
          icon: Icons.add_to_photos,
          closeOnTap: true,
          onTap: () {
            _addDescribe(dm.indexno);
            // _showSnackBar('配方已删除');
          },
        ),
      ],
      child: _getDescribeItemWidget(dm),
      // Container(
      //   height: dRecipeItemHeight,
      //   margin: EdgeInsets.only(left: 30.0, right: 0.0),
      //   // color: Colors.deepOrangeAccent,
      //   child: _getDescribeItemWidget(dm),
      // ),
    );
  }

  _getDescribeItemWidget(dm) {
    if (dm.ttype == 0) {
      return CachedNetworkImage(
        placeholder: (context, url) => AppWidget.getLocalImage('camera.png'),
        imageUrl: GlobalVar.webimageurl + dm.mainpic,
        fadeInCurve: Curves.easeIn,
        fadeOutCurve: Curves.easeOut,
        // alignment: Alignment.topCenter,
        fit: BoxFit.contain,
        // color: Colors.red,
      ); // Image.network(dm.mainpic);
    } else {
      return Container(
        margin: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          left: 5.0,
          right: 5.0,
        ),
        alignment: Alignment.center,
        child: Text(
          dm.memo,
          style: TextStyle(fontSize: 18.0, color: AppStyle.clTitle2FC),
        ),
      );
    }
  }

  _deleteDescribe(dm) {
    Map<String, dynamic> param = {"id": dm.id};
    DataHelpr.dataHandler('Template/DeleteDescribe', param, (ret) {
      DataHelpr.resultHandler(ret, () {
        templateModel.lstDescribe.remove(dm);
        TemplateBO.cleanCache();
        // AppPublicData.removeData(spfile);
        setState(() {});
        // _refreshData();
        // _showSnackBar('说明项已删除');
      });
    });
  }

  _addImageDescribe([int index = 0]) {
    var fparam = {
      "ot": 0,
      "tb": "Describe",
      "rid": 0, //.replaceAll("/", ""),
      "fn": "MainPic",
    };

    FileLoadHelper.selectPicture(context, fparam, (path) {}, (f) {
      HttpRetModel rm = f as HttpRetModel; // HttpRetModel.getExecRet(f);
      print(
          '@@@ TemplatePage._loadImage() ret : ${rm.ret} , message : ${rm.message}');
      if (rm.ret == 0) {
        _saveDescribeImage(index, rm.message);
        TemplateBO.cleanCache();
        // templateModel.mainpic = rm.message;
        // AppPublicData.removeData(spfile);

        // setState(() {});
        // _syncTemplateList();
        // _streamController.sink.add(templateModel);
      } else {
        AppToast.showToast(rm.message);
      }
    });
  }

  _saveDescribeImage(int index, String imgfile) async {
    DescribeModel dataModel = DescribeModel();
    dataModel.mainpic = imgfile;
    dataModel.ttype = 0;
    dataModel.indexno = (index == null || index == 0)
        ? (templateModel.lstDescribe.length + 1)
        : index;
    dataModel.tid = templateModel.id;

    Map<String, dynamic> param = {
      "Template_ID": templateModel.id,
      "IndexNo": dataModel.indexno,
      "MainPic": dataModel.mainpic,
      "TType": dataModel.ttype,
    };

    await DataHelpr.dataHandler('Template/AddDescribe', param, (ret) {
// DataHelpr.resultHandler(rm, (){});
      if (ret.ret == 0) {
        AppToast.showToast("保存成功！");
        print("@@@ TLDescribeEditPage._save() ret.id : ${ret.id}");
        TemplateBO.cleanCache();
        // AppPublicData.removeData(spfile);
        // SharePrefHelper.removeData(TemplateBO.getSpfile(templateModel.id));
        templateModel.lstDescribe.add(dataModel);
        setState(() {});
      } else {
        AppToast.showToast("保存失败：${ret.message}", 2);
      }
    });
  }

  _addDescribe([int index = 0]) async {
    // _addTextDescribe(index);
    var ret =
        await AppDiaglogHelper.showSelectTextList(context, ['图片', '文本', '取消']);
    print("@@@ ret : $ret");
    if (ret != null) {
      if (ret == 0)
        eventBus.fire(TemplateCallEvent('describeimage', index));
      else if (ret == 1)
        eventBus.fire(TemplateCallEvent('describetext', index));
    }

    // AppDialog.showSelectTextItemIOS(context, ['图片', '文本', '取消'], (v) {
    //   if (v == '0')
    //     // _addImageDescribe(index);
    //     eventBus.fire(TemplateCallEvent('describeimage', index));
    //   else if (v == '1') {
    //     // Timer(Duration(milliseconds: 100), _addTextDescribe(index));
    //     // await _addTextDescribe(context,index);
    //     eventBus.fire(TemplateCallEvent('describetext', index));
    //   }
    // });
    //  AppDialog.showSelectTextItemIOS(context, ['图片', '文本', '取消'], null).;
  }

  _addTextDescribe([int index = 0]) {
    print("@@@ TemplatePage._addTextDescribe() ... _index : $index");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TLDescribeEditPage(
                  templateModel: templateModel,
                  index: index,
                )));
  }

  _getRecipeUI() {
    if (templateModel.lstRecipe == null || templateModel.lstRecipe.length == 0)
      return Text('');

    Widget divider1 = Divider(
      indent: 20.0,
      endIndent: 20.0,
      color: Colors.grey[400],
      height: 1.0,
    );
    return ListView.separated(
      // padding: EdgeInsets.all(0.0),
      itemCount: templateModel.lstRecipe.length,
      itemBuilder: (BuildContext context, int position) {
        return _getRecipeItemUI(position); //_getSectionItemUI(position);
      },
      separatorBuilder: (BuildContext context, int index) {
        // return index % 2 == 0 ? divider1 : divider2;
        return divider1;
      },
    );
    // return Text('配方');
  }

  double dRecipeItemHeight = 50.0;
  _getRecipeItemUI(int index) {
    RecipeModel dm = templateModel.lstRecipe[index];
    return Slidable(
      actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
      actionExtentRatio: 0.25,
      // actions: <Widget>[
      //   //左侧按钮列表
      //   IconSlideAction(
      //     caption: '运行',
      //     color: Colors.green,
      //     icon: Icons.play_circle_outline,
      //     onTap: () => _runtTemplate(tm),
      //   ),
      // ],
      secondaryActions: <Widget>[
        //右侧按钮列表
        // IconSlideAction(
        //     caption: 'More',
        //     color: Colors.black45,
        //     icon: Icons.more_horiz,
        //     onTap: () => _showSnackBar('More'),

        // ),
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.clear,
          closeOnTap: true,
          onTap: () {
            AppDialog.showYesNoIOS(context, '删除确认', '您确定要删除该项配方吗？', () {
              _deleteRecipe(dm);
            });
            // _showSnackBar('配方已删除');
          },
        ),
        IconSlideAction(
          caption: '插入',
          color: Colors.green,
          icon: Icons.add_to_photos,
          closeOnTap: true,
          onTap: () {
            _addRecipe(dm.indexno);
            // _showSnackBar('配方已删除');
          },
        ),
      ],
      child: Container(
        height: dRecipeItemHeight,
        margin: EdgeInsets.only(left: 30.0, right: 0.0),
        // color: Colors.deepOrangeAccent,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  dm.name,
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: 80.0,
              child: Text(dm.amount.toString(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              width: 50.0,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                dm.unit,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _deleteRecipe(dm) {
    Map<String, dynamic> param = {"id": dm.id};
    DataHelpr.dataHandler('Template/DeleteRecipe', param, (ret) {
      DataHelpr.resultHandler(ret, () {
        templateModel.lstRecipe.remove(dm);
        TemplateBO.cleanCache();
        // AppPublicData.removeData(spfile);
        setState(() {});
        // _refreshData();
        // _showSnackBar('配方已删除');
      });
    });
  }

  _addRecipe(index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TLRecipeEditPage(
                  templateModel: templateModel,
                  index: index,
                )));
  }

  void _showSnackBar(String text) {
    print('@@@ TemplateListPage._showSnackBar() name : $text ... ');
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  double dTimeLineTop = 30.0;
  double dSectionItemHeight = 100.0;
  _getSectionItemUI(int index) {
    // String tparam =
    //     '上火 : ${templateModel.lstSection[index].uptemp} , 火力 : ${templateModel.lstSection[index].uppower} \r\n下火 : ${templateModel.lstSection[index].downtemp} , , 火力 : ${templateModel.lstSection[index].downpower} \r\n进水 : ${templateModel.lstSection[index].uptemp}';
    // print('### $tparam');
    String tparam =
        '上火 : ${templateModel.lstSection[index].uptemp}℃ , 火力 : ${templateModel.lstSection[index].uppower}\n下火 : ${templateModel.lstSection[index].downtemp}℃ , 火力 : ${templateModel.lstSection[index].downpower}\n进水# : ${templateModel.lstSection[index].uptemp}秒';
    return
        // ListTile(
        //   contentPadding: EdgeInsets.zero,
        //   leading:
        Container(
      height: dSectionItemHeight,
      // color: Colors.deepOrangeAccent,
      child: Row(
        children: <Widget>[
          //时间线
          Container(
            // padding: EdgeInsets.only(bottom: 12.0),
            alignment: Alignment.center,
            // height: double.infinity,
            width: 45.0,
            margin: EdgeInsets.only(left: 10.0),
            // color: Colors.grey[200],
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  child: Container(
                    // alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: index == 0 ? dTimeLineTop : 0.0,
                        bottom: index == (templateModel.lstSection.length - 1)
                            ? (dSectionItemHeight - dTimeLineTop)
                            : 0.0),
                    height: double.infinity,
                    width: 2.0,
                    color: Colors.green,
                    //  child: Text('楚玉'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: dTimeLineTop),
                  height: 22.0,
                  width: 22.0,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(11.0)),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //上下文本
          Expanded(
            child: Container(
              // color: Colors.lightBlue,
              // height: double.infinity,
              // width: double.infinity,
              child: Column(
                children: <Widget>[
                  //倒计时时长
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: double.infinity,
                    height: 40.0,
                    //  color: Colors.orangeAccent,
                    child: Text(
                      '${DateTimeHelper.changeSecToMS(templateModel.lstSection[index].timer)}',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: double.infinity,
                      height: double.infinity,
                      // color: Colors.deepOrange,
                      child: Text(
                        tparam,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // ),
      //  Icon(Icons.android),
      // title: Text('无与伦比的标题+$index'),
      // subtitle: Text('门隔花深梦旧游，夕阳无语燕归愁。玉纤香动小帘钩。'),
    );
  }

  _getTabUI(index) {
    // print('begin : _getTabUI($index ** $_index)');
    print('@@@ TemplatePage._getTabUI($index -- ${TemplateBO.index})');
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              // color: Colors.cyan,
              child: FlatButton(
                padding: EdgeInsets.zero,
                child: Text(
                  _getTitle(index),
                  style: TextStyle(
                    fontSize: 17.0,
                    color: TemplateBO.index == index
                        ? AppStyle.mainColor
                        : AppStyle.clTitle2FC,
                  ),
                ),
                onPressed: () {
                  _selectMenu(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _selectMenu(index) {
    // print('@@@ TemplatePage._selectMenu($index -- ${TemplateBO.index})');
    if (TemplateBO.index != index) {
      TemplateBO.index = index;
      setState(() {});
    }
    // print('after : _getTabUI($index -- $_index)');
  }

  // _gotoEditor() {
  //   // print("@@@ TemplatePage._gotoEditor() _index : $_index");
  // }

  _getTitle(index) {
    // print('_getTitle($index -- $_index)');
    String sret = '';
    switch (index) {
      case 0:
        sret = '运行时段';
        break;
      case 1:
        sret = '产品配方';
        break;
      case 2:
        sret = '详细说明';
        break;
      default:
        sret = '未知';
    }
    //return '$index' + sret + "-${TemplateBO.index}";
    return sret;
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
          color: templateModel.ischare == 1
              ? Colors.greenAccent
              : AppStyle.clTitle2FC,
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
        _refreshData();
        break;
      // case '1': //运行
      //   Navigator.of(context).pop('RUN');
      //   break;
      case '2': //共享
        _shareTemp();
        // TemplateModel tm = AppPublicData.mpDataModel[spfile] as TemplateModel;
        // print(
        //     '@@@ TemplatePage._barButtonClick() &&&&&&&&&&&&&& TemplateModel : ${tm.toJsonStr()}');
        break;
    }
  }

  _shareTemp() async {
    String t = '分享';
    int v = 1;
    if (templateModel.ischare == 1) {
      t = '取消分享';
      v = 0;
    }
    var ret = await AppDiaglogHelper.showYesNoDialog(context, '您确定要 $t 该模板吗？');
    if (ret != null && ret == 1) {
      HttpCallerSrv.post('Template/Modify',
              {"ID": templateModel.id, "IsShare": v}, GlobalVar.userInfo.tk)
          .then((f) {
        String jsonData = f;

        Map<String, dynamic> ret = json.decode(jsonData);
        HttpRetModel retmodel = HttpRetModel.fromJsonExec(ret);

        if (retmodel.ret == 0) {
          AppToast.showToast("$t 成功！");
          // DataHelpr.removeLocalData(spfile);
          templateModel.ischare = v;
          _streamController.sink.add(templateModel);
          // Navigator.of(context).pop('OK');
        } else {
          AppToast.showToast("$t 失败：${retmodel.message}", 2);
        }
      });
    }
    // AppDialog.showYesNoIOS(context, '$t 确认', '您确定要 $t 该模板吗？', () {
    //   HttpCallerSrv.post('Template/Modify',
    //           {"ID": templateModel.id, "IsShare": v}, GlobalVar.userInfo.tk)
    //       .then((f) {
    //     String jsonData = f;

    //     Map<String, dynamic> ret = json.decode(jsonData);
    //     HttpRetModel retmodel = HttpRetModel.fromJsonExec(ret);

    //     if (retmodel.ret == 0) {
    //       AppToast.showToast("$t 成功！");
    //       // DataHelpr.removeLocalData(spfile);
    //       templateModel.ischare = v;
    //       _streamController.sink.add(templateModel);
    //       // Navigator.of(context).pop('OK');
    //     } else {
    //       AppToast.showToast("$t 失败：${retmodel.message}", 2);
    //     }
    //   }).catchError((e) {
    //     AppToast.showToast("$t 失败：$e", 2);
    //   }).whenComplete(() {
    //     // isRun = 0;
    //   });
    //   // _refreshData();
    // });
  }

  _refreshData() async {
    // DataHelpr.removeLocalData(spfile);
    // AppPublicData.removeData(spfile);
    await TemplateBO.getTemplate(widget.id, 1);

    setState(() {
      // _getData();
    });

    // eventBus.fire(TimeSectionEvent(templateModel.id.toString()));
  }

  // _syncTemplateList() async {
  //   String spfilelist = TemplateBO.getSpfile();
  //   if (AppPublicData.mpDataList.containsKey(AppPublicData.mpDataList)) {
  //     List<dynamic> _lst = AppPublicData.mpDataList[spfilelist];
  //     if (_lst != null) {
  //       _lst.forEach((m) {
  //         if (m.id == templateModel.id) {
  //           m.mainpic = templateModel.mainpic;
  //           m.name = templateModel.name;
  //           m.memo = templateModel.memo;
  //           eventBus.fire(TemplateChangedEvent(widget.id));
  //         }
  //       });
  //     }
  //   }
  // }

  // _getMainpicUI() {
  //   // print('@@@ ControlPanelPage._getMainpicUI() cpIcon : $cpIcon');
  //   if (GlobalVar.platForm == 0 && templateModel.mainpic != null && templateModel.mainpic != '') {
  //     return Image.file(File(_localImage), fit: BoxFit.fitWidth);
  //   }

  //   if (_mainPic == 'camera.png')
  //     return AppWidget.getAssetImage(_mainPic, 45.0, Colors.grey[400]);

  //   return AppWidget.getCachedNetImage(_mainPic);
  // }

  Widget _getFlexibleHeader() {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      //padding: EdgeInsets.all(0.0),
      height: 128.0,
      // width: 160.0,
      // color: Colors.transparent,
      // decoration: BoxDecoration(
      //   color: Colors.transparent,
      //   border: Border(
      //     top: BorderSide(color: TemplateParam.clSplitLine, width: 1.0),
      //     // bottom: BorderSide(color: TemplateParam.clSplitLine, width: 1.0),
      //   ), //灰色的一层边框
      // ),
      child: Row(
        children: <Widget>[
          //子控件开始

          //左边图片
          GestureDetector(
            child:
                // _getHeaderPic(),
                Padding(
              padding: EdgeInsets.all(10.0),
              child: _getHeaderPic(),
            ),
            // child: AppWidget.getBroadContainer(
            //   _getMainpicUI(),
            //   128.0,
            //   170.0,
            //   5.0,
            //   Colors.grey[300],
            //   EdgeInsets.all(10.0),
            // ),
            // Container(
            //   height: 128.0,
            //   width: 170.0,
            //   child: _getMainpicUI(),
            //   margin: EdgeInsets.all(10.0),
            //   // alignment: Alignment.centerLeft,
            //   decoration: BoxDecoration(
            //     border:
            //         Border.all(color: Colors.grey[300], width: 1.0), //灰色的一层边框
            //     // color: Colors.tealAccent,
            //     borderRadius: BorderRadius.all(Radius.circular(3.5)),
            //   ),
            // ),
            // AppWidget.getBroadImage(templateModel.mainpic, 128.0, 170.0,
            //     EdgeInsets.all(10.0), EdgeInsets.all(0.0), 48.0),
            onTap: () {
              _loadImage(context);
            },
          ),

          //右边文字
          Expanded(
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(
                    left: 5.0, top: 13.0, right: 12.0, bottom: 12.0),
                alignment: Alignment.topLeft,
                // color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Container(
                    //   // height: 32.0,
                    //   margin: EdgeInsets.only(bottom: 8.0),
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     templateModel.name, // '高档手撕面包',
                    //     style: TextStyle(
                    //       fontSize: 20.0,
                    //       color: AppStyle.clTitle1FC,
                    //     ),
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        // height: 32.0,
                        // color: Colors.limeAccent,
                        child: Text(
                          templateModel.memo == null || templateModel.memo == ''
                              ? '模板说明 ...'
                              : templateModel.memo,
                          maxLines: 7,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: AppStyle.clTitle2FC,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TemplateEditPage(
                              id: templateModel.id,
                              name: templateModel.name,
                              memo: templateModel.memo,
                            ))).then((ret) {
                  print('@@@ ret : $ret');
                  if (ret != null && ret == 'OK') {
                    templateModel.name = GlobalVar.tempData['templatename'];
                    templateModel.memo = GlobalVar.tempData['templatememo'];
                    _streamController.sink.add(templateModel);
                    GlobalVar.tempData.remove('templatename');
                    GlobalVar.tempData.remove('templatememo');
                  }
                });
              },
            ),
          ),

          //子控件结束
        ],
      ),
    );
  }

  _getHeaderPic() {
    // String imgFile = '';
    // print(
    // '@@@ TemplatePage._getHeaderPic() templateModel.mainpic : ${templateModel.mainpic}');
    if (templateModel.mainpic == null ||
        templateModel.mainpic == '' ||
        templateModel.mainpic == 'camera.png') {
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
        templateModel.mainpic, dImageWidth, dImageHeight, dImageRadius);
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

  // _getSectionList() {
  //   // return SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),child:
  //   return ListView.builder(
  //     itemBuilder: (context, index) {
  //       return Text('SectionItem_$index');
  //     },
  //     itemCount: 30,
  //     itemExtent: 42.0,
  //   );
  //   // return SliverFixedExtentList(
  //   //     delegate: SliverChildBuilderDelegate(
  //   //       (BuildContext context, int index) {
  //   //         return _getSectionItem(index);
  //   //         // ListTile(title: Text('高度固定${index+1}'),
  //   //         // );
  //   //       },
  //   //       childCount: 10,
  //   //     ),
  //   //     itemExtent: 45.0);
  // }

  _loadImage(context) {
    var fparam = {
      "ot": 0,
      "tb": "Template",
      "rid": templateModel.id, //.replaceAll("/", ""),
      "fn": "MainPic",
    };

    FileLoadHelper.selectPicture(context, fparam, (path) {
      // _localImage = path;
      // _localImageFile = path;
      // setState(() {});
    }, (f) {
      HttpRetModel rm = f as HttpRetModel; // HttpRetModel.getExecRet(f);
      print('@@@ TemplatePage._loadImage() rm : ${rm.message}');
      if (rm.ret == 0) {
        templateModel.mainpic = rm.message;
        TemplateBO.cleanCache();

        // _localImageFile = null;
        // AppPublicData.removeData(spfile);
        setState(() {});
        // _syncTemplateList();
        // _streamController.sink.add(templateModel);
      } else {
        AppToast.showToast(rm.message);
      }
    });
  }

//   Widget _getTab() {
//     return Expanded(
//       child: Container(
//         // constraints: BoxConstraints.tightFor(width:111.0,height:111.0),
//         height: 250.0,
//         width: double.infinity,
//         color: Colors.red,
//       ),
//     );
//   }
}

class _SliverWidgetDelegate extends SliverPersistentHeaderDelegate {
  _SliverWidgetDelegate(this._c);

  final Container _c;

  @override
  double get minExtent => TemplateParam.dTitleHeight;

  @override
  double get maxExtent => TemplateParam.dTitleHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print("@@@ _SliverWidgetDelegate.build() ... _index : ${TemplateBO.index}");
    return _c;
  }

  @override
  bool shouldRebuild(_SliverWidgetDelegate oldDelegate) {
    return false;
  }
}

class _SliverSpaceDelegate extends SliverPersistentHeaderDelegate {
  _SliverSpaceDelegate(this._c);

  final Container _c;

  @override
  double get minExtent => TemplateParam.dSpaceHeight;

  @override
  double get maxExtent => TemplateParam.dSpaceHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _c;
  }

  @override
  bool shouldRebuild(_SliverSpaceDelegate oldDelegate) {
    return false;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class TemplateParam {
  static double dTitleHeight = 40.0;
  static double dSpaceHeight = 55.0;
  static Color clSplitLine =
      AppStyle.clSplitterLineColor; // Colors.redAccent; //.grey[100];
}
