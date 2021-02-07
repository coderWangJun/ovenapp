import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/app_dialog_helper.dart';
import 'package:ovenapp/Controls/AppImage.dart';
import 'package:ovenapp/Pages/TemplatePage.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Publics/AppObjHelper.dart';
import 'package:ovenapp/Publics/AppPublicData.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/AppToast.dart';

import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
// import 'package:ovenapp/Pages/TemplatePage.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';

class TemplateListPage extends StatefulWidget {
  TemplateListPage({Key key, this.iid}) : super(key: key);
  // final String cpname;this.cpname,
  // final String memo;
  final int iid;
  // final int dest;,  this.dest //0不能运行，1能运行

  @override
  _TemplateListPageState createState() => _TemplateListPageState();
}

class _TemplateListPageState extends State<TemplateListPage> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  double dImageWidth = 65.0;
  double dImageHeight = 50.0;
  double dImageRadius = 3.5;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    if (_isRefreshable == 0) return;
    _isRefreshable = 0;
    Timer(Duration(seconds: 15), () {
      _isRefreshable = 1;
    });
    _getData();
    await Future.delayed(Duration(milliseconds: 300));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted)
      setState(() {
        _getData();
      });
    _refreshController.loadComplete();
  }

  List<dynamic> _lstData;
  // int _ii = 1;
  int _pn = 1;
  // int _totalcount = 0;
  int _pagecount = 0;
// Future<List<dynamic>> fData;
  Future fData;

  // String spfile;
  int _isRefreshable = 1;

  var _onTemplateChangedEvent;

  @override
  void initState() {
    super.initState();
    // _lstData = [];
    // _getData();
    // if (GlobalVar.userInfo != null)
    //   spfile = GlobalVar.userInfo.id + 'templates';
    // else
    //   spfile = 'templates';
    // spfile = TemplateBO.getListSpfile();
    print(
        "@@@ => TemplateListPage.initState() ... iid : ${widget.iid} , GlobalVar.lstTemplate : ${GlobalVar.lstTemplate}");

    // if (GlobalVar.lstTemplate == null) {
    _getData();
    // } else
    //   _lstData = GlobalVar.lstTemplate.values.toList(); // .mpDataList[spfile];

    // if (_lstData == null) _getData();
    // fData =_getList();// Future.value(_lstData);
    // print(
    //     "@@@ => TemplateListPage.initState() ... iid : ${widget.iid} , cpname : ${widget.cpname}");

    _onTemplateChangedEvent =
        eventBus.on<TemplateChangedEvent>().listen((event) {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // int ii = widget.ic;
    // build(context);
    // Additional code
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();
    print("@@@ TemplateListPage.dispose() ...");
    _onTemplateChangedEvent.cancel();
  }

  // _getList() async {
  //   return await _getData();
  // }

  /*
   RefreshConfiguration(
         headerBuilder: () => WaterDropHeader(),        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
         footerBuilder:  () => ClassicFooter(),        // Configure default bottom indicator
         headerTriggerDistance: 80.0,        // header trigger refresh trigger distance
         springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // custom spring back animate,the props meaning see the flutter api
         maxOverScrollExtent :100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
         maxUnderScrollExtent:0, // Maximum dragging range at the bottom
         enableScrollWhenRefreshCompleted: true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
         enableLoadingWhenFailed : true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
         hideFooterWhenNotFull: false, // Disable pull-up to load more functionality when Viewport is less than one screen
         enableBallisticLoad: true, // trigger load more by BallisticScrollActivity
        child: MaterialApp(
            ........
        )
    );

  */

  @override
  Widget build(BuildContext context) {
    print("@@@ TemplateListPage.build() ...");
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: AppStyle.mainBackgroundColor, //Color(0xFFE82662),//
        title:
            Text('模板列表'), //(widget.cpname == '' ? '' : widget.cpname + ' ') +
        actions: _getActions(),
        elevation: 0.0,
        shape: AppWidget.getAppBarBottomBorder(),
      ),
      body:
          // Container(
          //   margin: EdgeInsets.only(top: 12.0),
          //   child:
          SafeArea(
        // minimum: EdgeInsets.only(top: 12.0),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          // onOffsetChange: (){},
          header: MaterialClassicHeader(
            backgroundColor: Colors.blueAccent,
          ), //WaterDropMaterialHeader(backgroundColor:  Color(0xFFE82662),),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                // body = Text("pull up load");
                return SizedBox(
                  height: 0.0,
                );
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败，请重试!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("松开加载更多数据 ...");
              } else {
                body = Text("我是有底线的 ...");
              }
              return Container(
                height: 50.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: null, // _onLoading,
          child: _queryData(),
        ),
        // Refresh(
        //   onFooterRefresh: onFooterRefresh,
        //   onHeaderRefresh: onHeaderRefresh,
        //   child: _queryData(),
        //   //ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder),
        // ), //_getRefreshUI(), //_getTemplateListFB(),
      ),
    );
  }

  List<Widget> _getActions() {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          color: Colors.black,
          iconSize: 32.0,
          onPressed: () {
            _addTemplate();
          }),
    ];
  }

  String js = '';
  _addTemplate() {
    AppDialog.showTextFieldIOS(context, '请输入模板名称', '模板名称', (ret) {
      if (ret == null || ret.toString().trim() == '') return;

      Map<String, dynamic> param = {
        "Name": ret,
        "ClientControlPanel_ID": 0,
        "IID": 0,
        // "EditType": edittype,
      };

      DataHelpr.dataHandler('Template/Add', param, (rm) {
        DataHelpr.resultHandler(rm, () {
          // _insertTemplate(rm, ret);
          _getData();
          // print('@@@ Add Template ret id : $id');
        });
      });
    });
  }

  _insertTemplate(rm, name) async {
    // int tid = int.parse(rm.id);
    // TemplateModel tm = TemplateModel(
    //     id: tid,
    //     name: name,
    //     ccpid: 0,
    //     mainpic: 'camera.png',
    //     cid: GlobalVar.userInfo.id,
    //     memo: '模板说明 ...',
    //     cname: GlobalVar.userInfo.name,
    //     createdt: DateTime.now().toString());
    // tm.lstSection = [];
    // tm.lstRecipe = [];
    // tm.lstDescribe = [];

    // TemplateBO.cleanCache();

    // if (GlobalVar.lstTemplate == null) GlobalVar.lstTemplate = {};
    // GlobalVar.lstTemplate[tid] = tm;
    // print('@@@ ControlPanelPage._addTemplate tm.id : ${tm.id}');

    // setState(() {});

    // TemplateBO.showTemplatePage(context, tm);

    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => TemplatePage(id: tid)));
  }

  _addTemplateFail(String err) {
    print('@@@ _addTemplateFail ret : $err');
    AppToast.showToast("新增模板失败：$err", 2);
  }

  Widget _queryData() {
    //注：此处为什么会在数据加载完毕后重新显示，是因为在 _getData里面使用了 setState((){}),不然数据不会刷新
    print('@@@ TemplateListPage._queryData() begin ... ');

    if (_lstData == null) return AppWidget.getCircularProgress();

    if (_lstData.length == 0) return AppWidget.getEmptyData(() {});

    return _getListViewUI();
    //ListView.builder(itemCount: _lstData.length, itemBuilder: (context,index){ return Text(index.toString()+'.'+_lstData[index].name);});
  }

  _getListViewUI() {
    Widget divider1 = Divider(
      indent: 10.0,
      endIndent: 10.0,
      color: Colors.grey[400],
    );
    // Widget divider2 = Divider(color: Colors.green);
    //ListView.separated 比 ListView.builder 多了一个分隔器  itemExtent: 50.0, //强制高度为50.0
    return ListView.separated(
      // padding: EdgeInsets.all(0.0),
      itemCount: _lstData.length,
      itemBuilder: (BuildContext context, int position) {
        return _getLine(position);
      },
      separatorBuilder: (BuildContext context, int index) {
        // return index % 2 == 0 ? divider1 : divider2;
        return divider1;
      },
    );
  }

//   _showSnackBar(name){
// print('@@@ TemplateListPage._showSnackBar() name : $name ... ');
// // _runtTemplate(tm);
//   }
  void _showSnackBar(String text) {
    print('@@@ TemplateListPage._showSnackBar() name : $text ... ');
    _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  final double leading = 0.3;
  final double textLineHeight = 0.3;

  _getLine(_index) {
    TemplateModel tm = _lstData[_index] as TemplateModel;
    // print('@@@ memo : ${tm.memo}');
    return Slidable(
      actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
      actionExtentRatio: 0.25,
      //左侧按钮列表
      // actions: <Widget>[
      //   IconSlideAction(
      //     caption: '运行',
      //     color: Colors.green,
      //     icon: Icons.play_circle_outline,
      //     onTap: () => _runtTemplate(tm),
      //   ),
      // ],
      //右侧按钮列表
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.clear,
          closeOnTap: true,
          onTap: () {
            _deleteTemp(tm);
            // _showSnackBar('模板已删除');
          },
        ),
      ],
      child: Container(
        height: 70.0,
        width: double.infinity,
        // color: Colors.cyan,
        margin: EdgeInsets.only(left: 12.0),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //图片
            // AppWidget.getBroadImage(tm.mainpic, 50.0, 65.0),
            _getHeaderPic(tm.mainpic),

            //文本
            Expanded(
              child: GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        height: 23.0,
                        margin: EdgeInsets.only(bottom: 3.0),
                        child: Text(
                          (_index + 1).toString() + '.' + tm.name,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: AppStyle.clTitle1FC,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // (_index + 1).toString() + '.' + _lstData[_index].name),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.topLeft,
                          child: Text(
                            tm.memo,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            // strutStyle: StrutStyle(forceStrutHeight: true, height: textLineHeight, leading: leading),
                            style: TextStyle(
                              fontSize: 16.5,
                              color: AppStyle.clTitle2FC,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //结束
                //   ],
                // ),
                // ),
                onTap: () {
                  // _gotoDetail(tm);
                  TemplateBO.showTemplatePage(context, tm);
                },
              ),
            ),

            //按钮
            Container(
              // width: widget.dest == 1 ? 96.0 : 48.0,
              width: 48.0,
              // height: 56.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // widget.dest == 1
                  IconButton(
                      color: Colors.grey[300],
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30.0,
                      ),
                      // iconSize: 26.0,
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        // _gotoDetail(tm);
                        print(
                            '@@@ TemplateListPage showTemplatePage() tm.id : ${tm.id}');
                        TemplateBO.showTemplatePage(context, tm);
                        // print('@@@ TemplateListPage 运行确认 tm.id : ${tm.id}');
                        // AppDialog.showYesNoIOS(
                        //     context, '运行确认', '您确定要运行此模板吗？', () {
                        //   _runtTemplate(tm);
                        // });
                        // Navigator.of(context).pop(tm.id.toString());
                      })
                  // : SizedBox(
                  //     height: 0.0,
                  //   ),
                  // IconButton(
                  //     color: AppStyle.clButtonGray,
                  //     icon: Icon(
                  //       Icons.highlight_off,
                  //       size: 32.0,
                  //     ),
                  //     // iconSize: 26.0,
                  //     padding: EdgeInsets.all(0.0),
                  //     onPressed: () {
                  //       AppDialog.showYesNoIOS(context, '删除确认', '您确定要删除此模板吗？',
                  //           () {
                  //         _deleteTemp(tm);
                  //       });
                  //     }),
                ],
              ),
            ),
            // onTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => TemplatePage(tm: tm)));
            // },
          ],
        ),
      ),
    );
  }

  _getHeaderPic(imgfile) {
    if (imgfile == null || imgfile == '' || imgfile == 'camera.png') {
      if (imgfile == null || imgfile == '') imgfile = 'camera.png';

      Icon icon = Icon(
        Icons.camera_alt,
        color: Colors.grey[400],
        size: 32.0,
      );

      return AppImage.rectMaterialIcon(
          icon, dImageWidth, dImageHeight, dImageRadius, Colors.grey[400]);
    }

    return AppImage.rectImage(imgfile, dImageWidth, dImageHeight, dImageRadius);
  }

//   _gotoDetail(tm) async {
// await AppPublicData.getTemplate(tm.id);
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => TemplatePage(templateModel: tm)));
//   }

  // _runtTemplate(tm) {
  //   AppDialog.showYesNoIOS(context, '运行确认', '您确定要运行此模板吗？', () {
  //     // print('@@@ TemplateListPage._runtTemplate() id : ${tm.id} , name : ${tm.name}, mainpic : ${tm.mainpic})');
  //     GlobalVar.tempData['template_id'] = tm.id;
  //     GlobalVar.tempData['template_name'] = tm.name;
  //     GlobalVar.tempData['template_mainpic'] = tm.mainpic;
  //     // print('@@@ TemplateListPage._runtTemplate() id : ${GlobalVar.tempData['template_id']} , name : ${GlobalVar.tempData['template_name']}, mainpic : ${GlobalVar.tempData['template_mainpic']})');
  //     Navigator.of(context).pop();
  //   });
  // }

  _deleteTemp(tm) async {
    var ret = await AppDiaglogHelper.showYesNoDialog(context, '您确定要删除此模板吗？');
    if (ret != null && ret == 1) {
      DataHelpr.dataHandler('Template/Delete', {"id": tm.id}, (rm) {
        DataHelpr.resultHandler(rm, () {
          AppToast.showToast('删除成功！');
          //refresh
          setState(() {
            _lstData.remove(tm);
          });
        });
      });
    }
    // AppDialog.showYesNoIOS(context, '删除确认', '您确定要删除此模板吗？', () {
    //   DataHelpr.dataHandler('Template/Delete', {"id": tm.id}, (rm) {
    //     DataHelpr.resultHandler(rm, () {
    //       AppToast.showToast('删除成功！');
    //       //refresh
    //       setState(() {
    //         _lstData.remove(tm);
    //       });
    //     });
    //   });
    // });
  }

  _getData() async {
    // AppPublicData.mpTemplates.remove(spfile);
    // await SharePrefHelper.removeData(spfile);
    // await AppPublicData.removeData(spfile);
    await TemplateBO.getTemplates(1);
    if (GlobalVar.lstTemplate != null)
      _lstData = GlobalVar.lstTemplate.values.toList();
    if (_lstData == null) _lstData = [];

    print('@@@ TemplateListPage._showSnackBar() _lstData : $_lstData');

    setState(() {});
  }

  // _getCSData() async {
  //   if (GlobalVar.userInfo == null) return;
  //   // _lstData = []; //此处类型必须为 dynamic,不然转换不过来
  //   // if (_lstData == null) _lstData = [];

  //   // if (_lstData != null)
  //   print(
  //       '@@@ TemplateListPage._getData _lstData.length (before) : ${_lstData == null ? 0 : _lstData.length}');

  //   var param = {
  //     "pageno": _pn,
  //     "orderby": "CreateDT DESC",
  //   };

  //   await DataHelpr.queryData('Template/List', param, TemplateModel(), (ret) {
  //     HttpRetModel rm = ret as HttpRetModel;
  //     print(
  //         '@@@ TemplateListPage._getData queryData => pagecount : ${rm.pagecount} , totalcount : ${rm.totalcount} , data.length : ${rm.data.length}');
  //     if (rm.ret == 0) {
  //       // _totalcount = rm.totalcount;
  //       if (mounted) {
  //         setState(() {
  //           if (_lstData == null) _lstData = [];
  //           _pagecount = rm.pagecount;

  //           // print(
  //           //     '@@@ TemplateListPage._getData _pagecount:$_pagecount , _pn:$_pn');
  //           for (int i = 0; i < rm.data.length; i++) {
  //             _lstData.add(rm.data[i]);
  //           }
  //           _pn++;
  //         });
  //       }
  //     }
  //     print(
  //         '@@@ TemplateListPage._getData _lstData.length (after) : ${_lstData.length}, _pn:$_pn');
  //   });

  //   // return _lstData;
  // }

  Future<Null> onFooterRefresh() {
    print(
        "@@@ TemplateListPage.onFooterRefresh() _pagecount:$_pagecount , _pn:$_pn");
    return Future.delayed(Duration(milliseconds: 100), () {
      // setState(() {
      // _itemCount += 10;
      // _getDataFromClass();
      if (_pagecount >= _pn) {
        _getData();
      }
      // if (_pagecount >= _pn) {
      //   setState(() {
      //     return _getData();
      //     //  _pn++;
      //   });
      // }
      // });r
    });
  }

  Future<Null> onHeaderRefresh() {
    print("@@@ TemplateListPage.onHeaderRefresh() ");
    return new Future.delayed(new Duration(milliseconds: 100), () {
      // setState(() {
      // _itemCount = 10;
      _lstData.clear();
      // _ii = 1;
      _pn = 1;
      // _getDataFromClass();
      // setState(() {
      _getData();
      // });
      // });
    });
  }
}
