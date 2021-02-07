import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
// import 'package:ovenapp/Publics/AppPublicData.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DateTimeHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class SelectTemplateList extends StatefulWidget {
  SelectTemplateList({Key key, this.iid}) : super(key: key);
  // final String cpname;this.cpname,
  // final String memo;
  final int iid;
  @override
  _SelectTemplateListState createState() => _SelectTemplateListState();
}

class _SelectTemplateListState extends State<SelectTemplateList> {
  String searchStr = '';
  List<dynamic> _lstData = [];
  // String spfile;
  @override
  void initState() {
    super.initState();

    // spfile = TemplateBO.getListSpfile();
    // _lstData = AppPublicData.mpDataList[spfile];
    // if (_lstData == null) _getData();
    if (GlobalVar.lstTemplate == null) {
      _getData();
    } else {
      _lstData = GlobalVar.lstTemplate.values.toList();
    }
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
    // print("@@@ SelectTemplateList.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: AppStyle.mainBackgroundColor, //Color(0xFFE82662),//
        // title: Text(templateModel.name),
        title: AppWidget.getSearcherTF('模板名称', (st, str) {
          // print('st ：$st , str : $str');
          if (str == null) return;
          searchStr = str;
          setState(() {});
        }, searchStr),
        elevation: 0.0,
        shape: AppWidget.getAppBarBottomBorder(),
        // actions: _getActions(),
      ),
      body:
          // Container(
          //   margin: EdgeInsets.only(top: 12.0),
          //   child:
          SafeArea(
        // minimum: EdgeInsets.only(top: 12.0),
        child: _getBodyUI(),
      ),
      // Refresh(
      //   onFooterRefresh: onFooterRefresh,
      //   onHeaderRefresh: onHeaderRefresh,
      //   child: _queryData(),
      //   //ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder),
      // ), //_getRefreshUI(), //_getTemplateListFB(),
    );
  }

  _getData() async {
    // await AppPublicData.removeData(spfile);
    await TemplateBO.getTemplates(1);

    setState(() {});
  }

  _getBodyUI() {
    print('@@@ DevicePage._getUI() ...');

    if (GlobalVar.userInfo == null) {
      return AppWidget.getEmptyData(() {
        _refreshData();
      });
    }

    // if (querycount == 0) return AppWidget.getCircularProgress();

    if (_lstData.length == 0) {
      return AppWidget.getEmptyData(() {
        _refreshData();
      });
    }

    // return ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder);
    return _getListViewUI();
  }

  _refreshData() {}

  _getListViewUI() {
    //BuildContext context, List<dynamic> data
    // print("@@@ TLSectionPage._getUI() begin --> ${DateTime.now()}");
    // print("@@@ TLSectionPage._getUI() data.length --> ${data.length}");

    List<Widget> _lst = new List<Widget>();
    // if (GlobalVar.userInfo == null) return ListView(children: _lst);

    // if (data.length > 0) {
    for (int i = 0; i < _lstData.length; i++) {
      TemplateModel tm = _lstData[i] as TemplateModel;
      if (searchStr != '') {
        if (tm.name.indexOf(searchStr) == -1) continue;
      }
      // print("@@@ DeviceBO._getDeviceUI() dm.name => ${dm.name}");

      Widget w =
          _getItemUI(tm); // Text(tm.tn.toString() + '.' + tm.sn.toString());
      _lst.add(w);
    }

    _lst.add(SizedBox(
      height: 80.0,
    ));
    // } else {
    //   return DataWidget.emptyData();
    // }

    return ListView(children: _lst);
  }

  _getItemUI(TemplateModel stm) {
    // print(
    //     "@@@ SelectTemplateList._getItemUI() TemplateModel => ${stm.toJsonStr()}");

    return Container(
      height: 75.0,
      width: double.infinity,
      // color: Colors.cyan,
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Colors.grey[300], width: 1.0, style: BorderStyle.solid),
        ),
        color: Colors.transparent, //此处与主色 color 属性不能同时出现，否则报错
      ),
      child: Row(
        children: <Widget>[
          //图片
          AppWidget.getBroadImage(stm.mainpic, 50.0, 67.0),

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
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
                        // height: 23.0,
                        // margin: EdgeInsets.only(bottom: 3.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: double.infinity,
                                // color: Colors.orangeAccent,
                                child: Text(
                                  stm.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: AppStyle.clTitle1FC,
                                  ),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: double.infinity,
                              // color: Colors.cyan,
                              width: 50.0,
                              child: Text(
                                DateTimeHelper.changeSecToMS(stm.timers),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            _getEditorUI(stm),
                          ],
                        ),
                      ),
                      // (_index + 1).toString() + '.' + _lstData[_index].name),
                    ),
                    // Container(
                    //   height: 1.0,
                    //   width: double.infinity,
                    //   color: Colors.grey[200],
                    //   margin: EdgeInsets.only(bottom: 3.0),
                    // ),
                    Container(
                      // color: Colors.deepPurpleAccent,
                      width: double.infinity,
                      height: 32.0,
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _getSectionList(stm),
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
                TemplateBO.showTemplatePage(context, stm);
              },
            ),
          ),
        ],
      ),
    );
    // return Container(
    //   // color: Colors.orange,
    //   alignment: Alignment.center,
    //   decoration: BoxDecoration(
    //     border: Border(
    //         bottom: BorderSide(color: Colors.grey[300], width: 1.0)), //灰色的一层边框
    //     // color: Colors.orange,
    //   ),
    //   height: 45.0,
    //   child: Row(
    //     // mainAxisAlignment: MainAxisAlignment.center,
    //     // crossAxisAlignment: CrossAxisAlignment.baseline,
    //     children: <Widget>[
    //       Text(stm.name),
    //       //编辑
    //       _getEditorUI(stm),
    //     ],
    //   ),
    // );
  }

  _getSectionList(TemplateModel tm) {
    // int totaltime = 0;

    List<Widget> _lst = [];
    if (tm == null || tm.lstSection == null || tm.lstSection.length == 0)
      return _lst;

    int _ii = 0;
    tm.lstSection.forEach((sm) {
      _lst.add(Container(
        width: 50.0,
        height: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            left: _ii == 0 ? 0.0 : 3.0, right: 3.0, bottom: 4.0, top: 1.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300], width: 0.6), //灰色的一层边框
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        child: Text(
          DateTimeHelper.changeSecToMS(sm.timer),
          style: TextStyle(
              fontSize: 18.0,
              color: AppStyle.clTitle2FC,
              fontWeight: FontWeight.bold),
        ),
      ));
      // totaltime = totaltime + sm.timer;
      _ii++;
      _lst.add(SizedBox(
        width: 3.0,
      ));
    });
    // tm.timers = totaltime;
    return _lst;
  }

  _getEditorUI(TemplateModel tm) {
    return Container(
      width: 40.0,
      alignment: Alignment.center,
      // color: Colors.tealAccent,
      child: IconButton(
          icon: Icon(
            Icons.play_arrow,
            color: Colors.blueAccent,
          ),
          iconSize: 36.0,
          padding: EdgeInsets.zero,
          onPressed: () {
            _runtTemplate(tm);
          }),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: <Widget>[
      //     IconButton(
      //         icon: Icon(
      //           Icons.play_arrow,
      //           color: Colors.blueAccent,
      //         ),
      //         iconSize: 32.0,
      //         padding: EdgeInsets.zero,
      //         onPressed: () {
      //           _runtTemplate(tm);
      //         }),
      //   ],
      // ),
    );
  }

  _runtTemplate(tm) {
    AppDialog.showYesNoIOS(context, '运行确认', '您确定要运行此模板吗？', () {
      // print('@@@ TemplateListPage._runtTemplate() id : ${tm.id} , name : ${tm.name}, mainpic : ${tm.mainpic})');
      GlobalVar.tempData['template_id'] = tm.id;
      // GlobalVar.tempData['template_name'] = tm.name;
      // GlobalVar.tempData['template_mainpic'] = tm.mainpic;
      // print('@@@ TemplateListPage._runtTemplate() id : ${GlobalVar.tempData['template_id']} , name : ${GlobalVar.tempData['template_name']}, mainpic : ${GlobalVar.tempData['template_mainpic']})');
      Navigator.of(context).pop();
    });
  }
}
