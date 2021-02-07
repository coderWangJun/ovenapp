import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/RecipeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Pages/TLRecipeEditPage.dart';
import 'package:ovenapp/Publics/AppPublicData.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class TLRecipePage extends StatefulWidget {
  TLRecipePage({Key key, this.id}) : super(key: key);
  final int id;

  @override
  _TLRecipePageState createState() => _TLRecipePageState();
}

class _TLRecipePageState extends State<TLRecipePage> {
  List<dynamic> _lstData = [];
  Future<List<dynamic>> fData;

  double dTitleWidth = 80.0;
  double dSubLineLeftEdig = 20.0;
  double dSubLineHeight = 45.0;

  Color clTitleFC = Colors.grey;

  String spfile; // = GlobalVar.spsection;
  TemplateModel templateModel;
  final dItemHeight = 60.0;

  @override
  void initState() {
    super.initState();

    spfile = TemplateBO.getSpfile();
    templateModel = AppPublicData.mpDataModel[spfile];
    _lstData = templateModel.lstRecipe;

    print("@@@ TLRecipePage.initState() ... template_id : ${widget.id}");

    // fData = Future.value(_getData());

    // _onMqttPayloadEvent = eventBus.on<TimeSectionEvent>().listen((event) {
    //   // DataHelpr.removeLocalData(spfile);
    //   String tid = event.tid;
    //   print('@@@ TLSectionPage.initState() _onMqttPayloadEvent tid : $tid');
    //   _refreshData();
    // });
    // tabController = new TabController(length: 3, vsync: this);
    // tabController.
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();

    // _onMqttPayloadEvent.cancel();
    print("@@@ TLRecipePage.dispose() ... ${DateTime.now()}");
    // tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ TLRecipePage.build() ... ${DateTime.now()}");

    return Scaffold(
      // key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: AppStyle.mainBackgroundColor, //Color(0xFFE82662),//
        title: Text(templateModel.name),
        actions: _getActions(),
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

  _getActions() {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          color: AppStyle.clTitle2FC,
          iconSize: 28.0,
          onPressed: () {
            _addItem();
          }),
    ];
  }

  _addItem() {}

  _getBodyUI() {
    print('@@@ DevicePage._getUI() ...');

    if (GlobalVar.userInfo == null ||
        _lstData == null ||
        _lstData.length == 0) {
      return AppWidget.getEmptyData(() {
        _refreshData();
      });
    }

    // if (querycount == 0) return AppWidget.getCircularProgress();

    // if (_lstData.length == 0) {
    //   return AppWidget.getEmptyData(() {
    //     _refreshData();
    //   });
    // }

    // return ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder);
    return _getListViewUI();
  }

  _getListViewUI() {
    List<Widget> _lst = new List<Widget>();
    for (int i = 0; i < _lstData.length; i++) {
      RecipeModel tm = _lstData[i] as RecipeModel;

      Widget w =
          _getItemUI(tm); // Text(tm.tn.toString() + '.' + tm.sn.toString());
      _lst.add(w);
    }

    _lst.add(SizedBox(
      height: 80.0,
    ));

    return ListView(children: _lst);
  }

  _getItemUI(RecipeModel dm) {
    return Container(
      // color: Colors.orange,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey[300], width: 1.0)), //灰色的一层边框
        // color: Colors.orange,
      ),
      height: 110.0,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget>[],
      ),
    );
  }

  _insertRecipe(rm) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TLRecipeEditPage(
                  templateModel: templateModel,
                ))).then((ret) {
      if (ret != null && ret == 'OK') {
        _refreshData();
      }
    });
  }

  _refreshData() {}

  _deleteRecipe(int id) async {}
}
