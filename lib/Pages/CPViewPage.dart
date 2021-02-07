import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/DeviceModel.dart';
import 'package:ovenapp/Models/SectionTimeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Pages/ControlPanelPage.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';

class CPViewPage extends StatefulWidget {
  CPViewPage({Key key, this.deviceModel, this.index}) : super(key: key);

// final DeviceModel deviceModel;this.deviceModel,
  final DeviceModel deviceModel;
  final int index;
  @override
  _CPViewPageState createState() => _CPViewPageState();
}

class _CPViewPageState extends State<CPViewPage> {
  PageController _pageController;
  List<Widget> _lstPage = [];
  int _curIndex = 0;

  // GlobalKey<ControlPanelPageState> cp1Key = GlobalKey<ControlPanelPageState>();
  // GlobalKey<ControlPanelPageState> cp2Key = GlobalKey<ControlPanelPageState>();
  // GlobalKey<ControlPanelPageState> cp3Key = GlobalKey<ControlPanelPageState>();

  // _getKey(ki) {
  //   switch (ki) {
  //     case 1:
  //       return cp1Key;
  //       break;
  //     case 2:
  //       return cp2Key;
  //       break;
  //     case 3:
  //       return cp3Key;
  //       break;
  //   }
  // }key: _getKey(ki),

  @override
  void initState() {
    super.initState();

    _curIndex = widget.index - 1;
    print("@@@ CPViewPage.initState() ... widget.index : ${widget.index}");
    // int ki = 1;
    _pageController = PageController(initialPage: widget.index - 1);
    widget.deviceModel.lstCP.forEach((cpm) {
      _lstPage.add(ControlPanelPage(controlPanelModel: cpm));
      // ki++;
    });
    // print(
    //     "@@@ CPViewPage.initState() ... id:${widget.deviceModel.id} , index : ${widget.index}");
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();

    print("@@@ CPViewPage.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ CPViewPage.build() ... ");
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //标题栏
        appBar: AppBar(
          backgroundColor: AppStyle.clTitleBC,
          title: Text(widget.deviceModel.name),
          actions: _getActions(),
          shape: AppWidget.getAppBarBottomBorder(),
          elevation: 0.0,
        ),
        //   preferredSize: AppStyle.getAppBarHeight(),
        // ),
        //主界面
        body: PageView.builder(
          itemBuilder: (context, index) {
            return _lstPage[index];
          },
          itemCount: _lstPage.length,
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          onPageChanged: (index) {
            _curIndex = index;
            print("@@@ CPViewPage.onPageChanged($index)");
          },
        )
        //  Container(
        //   child: Text('data'),
        // ),
        );
  }

  _getActions() {
    return <Widget>[
      FlatButton(
          onPressed: () {
            eventBus.fire(SaveTemplateEvent(_curIndex + 1));
          },
          child: Text(
            '存为模板',
            style: TextStyle(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
              fontSize: 18.5,
            ),
          )),
      // IconButton(
      //     icon: Icon(Icons.save),
      //     color: AppStyle.clTitle2FC,
      //     iconSize: 28.0,
      //     onPressed: () {
      //       eventBus.fire(SaveTemplateEvent(_curIndex + 1));
      //     }),
    ];
  }
}
