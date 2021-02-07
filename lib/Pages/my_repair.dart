// import 'package:ovenapp/Services/HttpCallerSrv.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Models/NewsModel.dart';
// import 'package:ovenapp/Models/HttpRetModel.dart';
// import 'package:ovenapp/Controls/MaterialButton.dart';
// style: TextStyle(fontSize: 18.0,color: Color(0xFF1B1B1B),),

  // Timer _timer;
//  _createTimer() {
//     _timer = new Timer.periodic(const Duration(seconds: 6), (timer) {
//       if (_lstNews == null) {
//         print("@@@ HomePage._createTimer() _lstNews => is null");
//         setState(() {
//           _lstNews = [new MyControl().overtimeWidget()];
//         });
//       } else
//         print("@@@ HomePage._createTimer() _lstNews => " +
//             _lstNews.length.toString());

//       if (_timer != null) {
//         _timer.cancel();
//         _timer = null;
//       }
//     });
//   }

  /*
   * 根据image路径获取图片
   * 这个图片的路径需要在 pubspec.yaml 中去定义
   */
  // Image getTabImage(path) {
  //   return new Image.asset(path, width: 30.0, height: 30.0);
  // }

  // floatingActionButton: FloatingActionButton(
  //   onPressed: (){
  //     Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
  //       return EachView('New Page');
  //     }));
  //   },
  //   tooltip: 'Increment',
  //   child: Icon(
  //     Icons.add,
  //     color: Colors.white,
  //   ),
  // ),

  //   Widget build(BuildContext context) {
  //   return new Scaffold(
  //     floatingActionButton: new Builder(builder: (BuildContext context) {
  //       return new FloatingActionButton(
  //         child: const Icon(Icons.add),
  //         tooltip: "Hello",
  //         foregroundColor: Colors.white,
  //         backgroundColor: Colors.black,
  //         heroTag: null,
  //         elevation: 7.0,
  //         highlightElevation: 14.0,
  //         onPressed: () {
  //           Scaffold.of(context).showSnackBar(new SnackBar(
  //             content: new Text("FAB is Clicked"),
  //           ));
  //         },
  //         mini: false,
  //         shape: new CircleBorder(),
  //         isExtended: false,
  //       );
  //     }),
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //   );
  // }

//   import 'package:flutter/material.dart';
// import 'package:ovenapp/Classes/MqttClass.dart';
// // import 'package:mqtt_client/mqtt_client.dart';

// // import '../Classes/MqttClass.dart';
// // import '../Classes/AppToast.dart';
// import '../Publics/GlobalVar.dart';
// import '../Services/EventBusSrv.dart';

// class DevicePage extends StatefulWidget {
//   @override
//   _DevicePageState createState() => new _DevicePageState();
// }

// class _DevicePageState extends State<DevicePage> {
//   // String loginid = "13237199233";
//   // String username = "010001";
//   // String password = "1";
//   // String server = "www.cfdzkj.com";
//   // int port = 1888;
//   // MqttClient mqttClient;
//   int mii = 1;
//   // MqttClass mqttClass;
//   String mmv = "";
//  var _onMqttPayloaded;
//   // _onMqttPayloaded = eventBus.on<MqttPayloadEvent>().listen((event) {
//   //     String mv=event.data;
//   //     setState(() {
//   //       mmv=mv;
//   //     });
//   // });

//   @override
//   void initState() {
//     super.initState();

//     // GlobalVar.mqttClass = new MqttClass(GlobalVar.userInfo.loginid);

//   _onMqttPayloaded = eventBus.on<MqttPayloadEvent>().listen((event) {
//       String mv=event.data;
//       setState(() {
//         print("@@@ => _onMqttPayloaded.setState() : "+mv);
//         mmv=mv;
//       });
//   });

//     print("@@@ => DevicePage.initState()");
//   }

// // class MyPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print("@@@ => DevicePage.build() ... Start");
//     return new Scaffold(
//         // appBar: new AppBar(
//         //   title: new Text('我的'),
//         // ),
//         body: new SafeArea(
//       child: new Column(children: <Widget>[
//         new RaisedButton(
//           child: new Text('创建 MqttClient'),
//           onPressed: () {
//             print("@@@ => 1. Create MqttClient");
//             // mqttClass = new MqttClass();
//             if (GlobalVar.mqttClass == null) {
//               GlobalVar.initMqttSrv();
//             }
//             // GlobalVar.mqttClass = new MqttClass();
//             // return;

//             // print("@@@ => 1. Create MqttClient");
//             // // Map<String,String> param={"username":"","password":""}; +GlobalVar.userInfo.loginid
//             //  print("@@@ => 2. MqttClient.withPort / "+server+"."+ loginid+"."+  port.toString());
//             // mqttClient= MqttClient.withPort(server, loginid, port);
//             // print("@@@ => 3. mqttClient.connect / "+username +"."+ password);
//             //  mqttClient.connect(username,password);
//             //  .then((e){
//             //    print(e);
//             //  });
//             // GlobalVar.mqttClass = new MqttClass(GlobalVar.userInfo.loginid);
//           },
//         ),

//         new RaisedButton(
//           child: new Text('连接 MqttClient'),
//           onPressed: () {
//             print("@@@ => 1. Connect MqttClient");
//             if (MqttClass.mqttClientState == "disconnect")
//               GlobalVar.mqttClass.connect();
//           },
//         ),

//         new RaisedButton(
//           child: new Text('订阅主题'),
//           onPressed: () {
//             print("@@@ => 1. Subscribe Topic");
//             // mqttClass.subscribe("/05D8FF333136595043187610");
//             if (MqttClass.mqttClientState == "connect")
//               GlobalVar.mqttClass.subscribe("/oven/app/13237199233");
//           },
//         ),

//         new RaisedButton(
//           child: new Text('发布消息'),
//           onPressed: () {
//             print("@@@ => 1. Publish Message");
//             // mqttClass.subscribe("/05D8FF333136595043187610");
//             String msg =
//                 '{"set":[367,297],"show":[3,6],"power":[2,7],"timer":[121,0],"state":1,"steam":[202,11],"center":[12,15],"tn":$mii}';
//             //mii.toString()+".客舍门临漳水边，垂杨下系钓鱼船。"
//             if (MqttClass.mqttClientState == "connect")
//               GlobalVar.mqttClass.publishMessage("/13237199233", msg);
//             mii++;
//           },
//         ),

//         new RaisedButton(
//           child: new Text('设置变量'),
//           onPressed: () {
//             mmv = new DateTime.now().toString();
//             setState(() {
//               _getMM(mmv);
//             });
//           },
//         ),

//         new RaisedButton(
//           child: new Text('断开 MqttClient'),
//           onPressed: () {
//             print("@@@ => 1. Disconnect MqttClient");
//             if (MqttClass.mqttClientState == "connect")
//               GlobalVar.mqttClass.disconnect();
//           },
//         ),

//         // _getMM('{"set":[123,987],"show":[3,6],"power":[2,7],"timer":[121,0],"state":1,"steam":[202,11],"center":[12,15],"tn":36} '),
//         _getMM(mmv),
//       ]),
//     ));
//   }

// @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     //取消订阅
//     _onMqttPayloaded.cancel();
//   }

//   Text _getMM(String mm) {
//     return new Text(mm);
//   }
// }

// Widget _getLeading() {
//     return Center(
//         widthFactor: 2,
//         child: Text(
//           "设备",
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 18.0,color: Color(0xFF1B1B1B),),
//         ));
//   }

//   List<Widget> _getActions() {
//     return <Widget>[
//       // IconButton(icon: Icon(Icons.search),tooltip: '搜索', iconSize: 35, onPressed: null),//标题右侧按钮
//       IconButton(
//           icon: Icon(Icons.search),
//           tooltip: '搜索',
//           iconSize: 35,
//           onPressed: null) //标题右侧按钮
//     ];
//   }

//设置边框的不同边的宽度
/*
 border: Border(
          left: BorderSide(
              color: Colors.purpleAccent, width: 5.0, style: BorderStyle.solid),
          top: BorderSide(
              color: Colors.purpleAccent, width: 1.0, style: BorderStyle.solid),
          right: BorderSide(
              color: Colors.purpleAccent, width: 1.0, style: BorderStyle.solid),
          bottom: BorderSide(
              color: Colors.purpleAccent, width: 1.0, style: BorderStyle.solid),
        ),
*/
//IconButton 用法
                    // child: IconButton(
            //     icon: Icon(Icons.search,),
            //     color: Colors.grey,
            //     iconSize: 28.0,
            //     onPressed: () {
            //       print("@@@ searchController.text : " + searchController.text);
            //     }),
            
          //   Container(
          //   color: Colors.red,
          //   child: FlatButton(              
          //     child: Icon(
          //       Icons.clear,
          //       color: Colors.grey[300],
          //       textDirection: TextDirection.rtl,
          //       // matchTextDirection:true,
          //       // size: 22,
          //     ),
          //     onPressed: () {
          //       searchController.text="";
          //     },
          //   ),
          //   width: 36.0,
          //   alignment: Alignment.center,
          // ),

          // NavigatorUtil.intentToPage(context, new SearchPage(), pageName: "SearchPage");

//leading用法
      //     leading: new Builder(
      //     builder: (BuildContext context){
      //       return new GestureDetector(//设置事件
      //         child: new Icon(//设置左边的图标
      //           Icons.account_circle,//设置图标内容
      //           color: Colors.white,//设置图标的颜色
      //         ),
      //         onTap:(){
      //           Scaffold.of(context).showSnackBar(
      //               new SnackBar(content: new Text('点击'))
      //           );
      //         },
      //         onLongPress: (){
      //           Scaffold.of(context).showSnackBar(
      //               new SnackBar(content: new Text('长按'))
      //           );
      //         },
      //         onDoubleTap: (){
      //           Scaffold.of(context).showSnackBar(
      //               new SnackBar(content: new Text('双击'))
      //           );
      //         },
      //       );
      //     }
      // ),

      //popmenu用法
      /*
      //设置显示在右边的控件
      actions: <Widget>[
        new Padding(
          child: new Icon(
            Icons.add,
            color: Colors.white
          ),
          padding: EdgeInsets.all(10.0),
        ),
        new Padding(
          child: new Icon(
              Icons.account_box,
              color: Colors.white
          ),
          padding: EdgeInsets.all(10.0),
        ),
        new PopupMenuButton(
          itemBuilder: (BuildContext context){
            return <PopupMenuItem<String>>[
              PopupMenuItem(
                child: new Text("menu item 1"),
                value: "第一个",
              ),
              PopupMenuItem(
                child: new Text("menu item 2"),
                value: "第二个",
              ),
            ];
          },
          icon: new Icon(
              Icons.ac_unit,
              color: Colors.white
          ),
          onSelected: (String selected){
            print("选择的：" + selected);
          },
        ),
      ],
      bottom:PreferredSize(//设置标题下面的view
        child: new Container(
          height: 50.0,
          child: new Center(
            child: new Text(
              '显示在title下面',
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
    );
  }
      */

      //路由
      /*
      Navigator.of(context).pushNamed("/devicedetail");
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new ControlPanelPage(uuid:cameraScanResult)),
      Navigator.pushNamed(context, pageA);

      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageB(
                    data: "要传递的数据",
                  ),
            ),
          );
*/
    // print("@@@ => MaintainPage._getWidgetSize($k) offset : $offset");
    // print("@@@ => MaintainPage._getWidgetSize($k) size : $size");
    // print("@@@ SharePrefHelper.getData (key:$key) => value : $value");

    //局部更新，滑动条
    /*
    class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _counter = 0;
  final StreamController<int> _streamController = StreamController<int>();

  double _power = 3.0;
  bool _isOpen = false;
  double _temp = 30.0;
  double slider = 2.0;
  @override
  void initState() {
    super.initState();
    print("@@@ => MyPage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    print("@@@ MyPage.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ => MyPage.build() ... ");

    return Scaffold(
      //  appBar: AppBar(title: Text('Stream version of the Counter App')),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 45,
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).pushNamed("/login");
              }),
          Center(
            child: StreamBuilder<int>(
                // 监听Stream，每次值改变的时候，更新Text中的内容
                stream: _streamController.stream,
                initialData: _counter,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Text('You hit me: ${snapshot.data} times');
                }),
          ),
          CupertinoSwitch(
              value: _isOpen,
              onChanged: (v) {
                setState(() {
                  _isOpen = v;
                });
                print("_isOpen : " + _isOpen.toString());
              }),
          Container(
            // width: double.infinity,
            height: 60.0,
            child: CupertinoSlider(
                // label: '$_power',
                value: _power,
                // divisions: 10,
                max: 99,
                min: 0,
                onChanged: (v) {
                  setState(() {
                    _power = v;
                  });
                  print("_power : " + _power.toString());
                }),
          ),
          RaisedButton(
              child: Text("设置温度参数"),
              onPressed: () {
                UpDownFireModel udm = UpDownFireModel(
                    index: 1, power: 9.0, temp: 300.0, isOpen: 1);
                AppDialog.showUpDownFireParamIOS(context, udm, (m) {
                  print("@@@ m : ${m.tojson()}");
                });
              }),
          Container(
            height: 160.0,
            alignment: Alignment.center,
            // color: Colors.orangeAccent,
            child: Slider(
                label: '温度值: ${slider.round().toInt()} ℃',
                value: slider,
                divisions: 100,
                max: 100.0,
                min: 0.0,
                activeColor: Colors.orangeAccent,
                onChanged: (v) {
                  //print("_temp : " + _temp.toString());
                  // UpDownFireModel m = v as UpDownFireModel;
                  // print("v : ${m.tojson()}");
                  setState(() {
                    slider = v;
                  });
                }),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // 每次点击按钮，更加_counter的值，同时通过Sink将它发送给Stream；
          // 每注入一个值，都会引起StreamBuilder的监听，StreamBuilder重建并刷新counter
          _streamController.sink.add(++_counter);
        },
      ),
    );
  }
}
    */

    //查找当前索引
    /*
    而其它方法也不太好，我最后用下面新的方式实现：

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
List<TabModel> _tabs = [];  // 动态选项卡

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
          key: _scaffoldKey,
          ...
      )
  )}
然后利用下面方式获取索引：

DefaultTabController.of(_scaffoldKey.currentState.context).index;
或者

DefaultTabController.of(_scaffoldKey.currentContext).index;
其中设置索引可以切换Tab，像如下代码：

DefaultTabController.of(_scaffoldKey.currentContext).index = 1;
但是这种方式会有个奇怪的效果，建议换成如下方式：

DefaultTabController.of(_scaffoldKey.currentContext).animateTo(index);
    */

    /*
    Card(
                margin: EdgeInsets.all(0.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      // color: Colors.pinkAccent,
                      child: _getTextField("运行时间 : ", timerController, 99),
                    ),
                    Expanded(
                      // color: Colors.pinkAccent,
                      child: _getTextField("进水时间 : ", steamtController, 100),
                    ),
                  ],
                ),
              ),
    */

    //文本框的输入
    /*
    Container(
      // color: Colors.orangeAccent,
      margin: EdgeInsets.only(left: 2.0, right: 2.0, bottom: 0.0),
      height: 50.0,
      // margin: EdgeInsets.all(0.0),
      width: double.infinity,
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0),
      decoration: BoxDecoration(
          // border:
          //     Border(bottom: BorderSide(color: Colors.red, width: 1.0)), //灰色的一层边框

          // border:
          //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
          // color: Colors.white,
          // borderRadius: BorderRadius.all(Radius.circular(5.0)),
          // borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(3.0),
          //   bottomRight: Radius.circular(3.0),
          //   topLeft: Radius.zero,
          //   topRight: Radius.zero,
          // ),
          ),
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            child: Text(
              name,
              style: TextStyle(
                color: AppStyle.clTitle2FC,
                fontSize: 16.5,
              ),
            ),
          ),
          Expanded(
            // child: Container(
            // width: 120.0,
            child: CupertinoTextField(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  controller:
                      (name == 'up' ? uptempController : downtempController),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  style: TextStyle(color: Colors.redAccent, fontSize: 18.0),
                  //输入完成时调用
                  onEditingComplete: () {
                    if (num.parse(controller.text) > maxValue) {
                    controller.text = maxValue.toString();
                  }
                  },
                ),

            // TextField(
            //     // controller: controller,
            //     keyboardType: TextInputType.number,
            //     // scrollPadding: EdgeInsets.all(0.0),
            //     // maxLength: 3,
            //     style: TextStyle(
            //       color: Colors.redAccent,
            //       fontSize: 25.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     decoration: InputDecoration(
            //       // fillColor: Colors.grey,
            //       contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            //       // prefixIcon: Icon(
            //       //   Icons.phone,
            //       //   color: AppStyle.cpCloseColor,
            //       // ),
            //       // prefixText:
            //       //     name, //Text(name,style: TextStyle(color: AppStyle.clTitle2FC,fontSize: 16.5,),),
            //       // prefixStyle: TextStyle(
            //       //   color: AppStyle.clTitle2FC,
            //       //   fontSize: 16.5,
            //       // ),
            //       // suffixText: unit,
            //       // suffixStyle: TextStyle(
            //       //   color: Colors.red,
            //       //   fontSize: 16.5,
            //       // ),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(0),
            //         borderSide: BorderSide.none,
            //       ),
            //     ),
            //     //输入完成时调用
            //     onEditingComplete: () {
            //       if (num.parse(controller.text) > maxValue) {
            //         controller.text = maxValue.toString();
            //       }
            //     }),
            // ),
          ),
          Container(
            width: 60.0,
            child: Text(
              unit,
              style: TextStyle(
                color: AppStyle.clTitle2FC,
                fontSize: 16.5,
              ),
            ),
          ),
        ],
      ),
    );
    */

    //Container 的边框设置
    /*
    decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1.0),
        // border: Border(
        //   left: BorderSide(
        //       color: Colors.purpleAccent, width: 8.0, style: BorderStyle.solid),
        //   top: BorderSide(
        //       color: Colors.purpleAccent, width: 1.0, style: BorderStyle.solid),
        //   right: BorderSide(
        //       color: Colors.purpleAccent, width: 1.0, style: BorderStyle.solid),
        //   bottom: BorderSide(
        //       color: Colors.purpleAccent, width: 1.0, style: BorderStyle.solid),
        // ),
        color: Colors.transparent, //此处与主色 color 属性不能同时出现，否则报错
        // borderRadius:BorderRadius.vertical(top:Radius.circular(20.0),bottom: Radius.circular(20.0)),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        // borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(20.0),
        //     //topRight: Radius.circular(20.0),
        //     bottomRight: Radius.circular(20.0),
        //     //bottomLeft: Radius.circular(20.0),
        //   ),
      ),
    */

    /*
        signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
    }
    */

    /*
    <?xml version="1.0" encoding="utf-8"?>
<resources>
    <paths>
        <root-path name="rp" path="jiangbin"/>
        <files-path name="fp" path="jiangbin"/>
        <cache-path name="cp" path="jiangbin" />
        <external-path name="ep" path="jiangbin"/>
        <external-files-path name="efp" path="jiangbin" />
        <external-cache-path name="ecp" path="jiangbin" />
    </paths>
</resources>


    <!-- android:versionCode="3"
    android:versionName="1.20.323" -->
    */

    /*
     return Dismissible(
      key: Key(_index.toString()),
      direction: DismissDirection.horizontal,
      /*定义滑动的方向*/
      onDismissed: (direction) {
        // list.removeAt(index);
        // _showSnakeBar("$curItem 被划走了");
        print('@@@ TemplateListPage._getLine() onDismissed($direction) ... ');
      },
      background: Container(
        width: 50.0,
          child: Center(
            child: Text('运行'),
          ),
          color: Colors.green),
      /*设置滑动时底部显示的内容*/
      secondaryBackground: Container(
         width: 50.0,
          child: Center(
            child: Text('删除'),
          ),
          color: Colors.red),
    */

    //侧滑控件
    /* return Slidable(
      actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
      actionExtentRatio: 0.25,
        //左侧按钮列表
      actions: <Widget>[
        IconSlideAction(
          caption: '运行',
          color: Colors.green,
          icon: Icons.play_circle_outline,
          onTap: () => _runtTemplate(tm),
        ),
      ],
        //右侧按钮列表
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.clear,
          closeOnTap: false,
          onTap: () {
            _deleteTemp(tm);
            _showSnackBar('模板已删除');
          },
        ),
      ],
      dismissal: SlidableDismissal(
                child: SlidableDrawerDismissal(),
                onDismissed: (actionType) {
                  // _showSnack(
                  //     context,
                  //     actionType == SlideActionType.primary
                  //         ? 'Dismiss Archive'
                  //         : 'Dimiss Delete');
                  // setState(() {
                  //   list.removeAt(index);
                  // });
                },
                onWillDismiss: (actionType) {
                  return true;
                  // return showDialog<bool>(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       title: Text('Delete'),
                  //       content: Text('Item will be deleted'),
                  //       actions: <Widget>[
                  //         FlatButton(
                  //           child: Text('Cancel'),
                  //           onPressed: () => Navigator.of(context).pop(false),
                  //         ),
                  //         FlatButton(
                  //           child: Text('Ok'),
                  //           onPressed: () => Navigator.of(context).pop(true),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
                },
              ),
      child: Container(
        height: 70.0,
        width: double.infinity,
        // color: Colors.cyan,
        margin: EdgeInsets.only(left: 8.0),
        child: Row(
          children: <Widget>[
            //图片
            AppWidget.getBroadImage(tm.mainpic, 50.0, 65.0),

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
                  AppObjHelper.showTemplatePage(context, tm);
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
                        AppObjHelper.showTemplatePage(context, tm);
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
  */

  /*
   PopupMenuButton _popMenu() {
    return PopupMenuButton(
      itemBuilder: (context) => _getPopupMenu(context),
      onSelected: (value) {
        print("onSelected");
        _selectValueChange(value);
      },
      onCanceled: () {
        print("onCanceled");
        bgColor = Colors.white;
        setState(() {});
      },
    );
  }

  _selectValueChange(String value) {
    setState(() {});
  }

  _showMenu(BuildContext context, LongPressStartDetails detail) {
    RenderBox renderBox = anchorKey.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
    final RelativeRect position = RelativeRect.fromLTRB(
        detail.globalPosition.dx, //取点击位置坐弹出x坐标
        offset.dy, //取text高度做弹出y坐标（这样弹出就不会遮挡文本）
        detail.globalPosition.dx,
        offset.dy);
    var pop = _popMenu();
    showMenu(
      context: context,
      items: pop.itemBuilder(context),
      position: position, //弹出框位置
    ).then((newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled();
        return null;
      }
      if (pop.onSelected != null) pop.onSelected(newValue);
    });
  }

  _showMenu1(BuildContext context) {
    // RenderBox renderBox = anchorKey.currentContext.findRenderObject();
    // var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
    RenderBox box = context.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    _offset = offset;
    // print("@@@ => MaintainPage._getWidgetSize($k) offset : $offset");
    //获取size
    Size size = box.size;

    final RelativeRect position = RelativeRect.fromLTRB(
        _offset.dx, //取点击位置坐弹出x坐标
        offset.dy, //取text高度做弹出y坐标（这样弹出就不会遮挡文本）
        10,
        offset.dy);
    var pop = _popMenu();
    showMenu(
      context: context,
      items: pop.itemBuilder(context),
      position: position, //弹出框位置
    ).then((newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled();
        return null;
      }
      if (pop.onSelected != null) pop.onSelected(newValue);
    });
  }

  _getPopupMenu(BuildContext context) {
    return <PopupMenuEntry>[
      PopupMenuItem(
        value: "复制",
        child: Text("复制"),
      ),
      // PopupMenuItem(
      //   value: "收藏",
      //   child: Text("收藏"),
      // ),
    ];
  }

  Offset _offset;
  Size _size;
  _getWidgetSize(GlobalKey k) {
    RenderBox box = k.currentContext.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    _offset = offset;
    print("@@@ => MaintainPage._getWidgetSize($k) offset : $offset");
    //获取size
    Size size = box.size;
    _size = size;
    print("@@@ => MaintainPage._getWidgetSize($k) size : $size");
  }

  _showPMenu(double l, double t) async {
    print("@@@ AppStyle.getAppBarHeight() l : $l");
    print("@@@ AppStyle.screenSize.width t : $t");
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(l, t, 1000.0, 1000.0),
      items: <PopupMenuItem<String>>[
        new PopupMenuItem(value: "0", child: new Text("存为模板")),
        new PopupMenuItem(value: "1", child: new Text("载入模板")),
        new PopupMenuItem(value: "2", child: new Text("报修")),
        new PopupMenuItem(value: "3", child: new Text("设置")),
        new PopupMenuItem(value: "4", child: new Text("帮助")),
      ],
    );
  }
  */

   // Center(
      //   child: Container(
      //     // color: Colors.deepOrangeAccent,
      //     height: 90.0,
      //     width: 90.0,
      //     child: ClipRRect(
      //       // clipper: CustomClipper<RRect>(3.0),
      //       borderRadius: BorderRadius.all(Radius.circular(45.0)),
      //       clipBehavior: Clip.antiAlias,
      //       child: Image.file(
      //         File(_avatarFile),
      //         fit: BoxFit.fitWidth,
      //       ),
      //     ),
      //     // child: Image.file(
      //     //   File(_avatarFile),
      //     //   fit: BoxFit.fitWidth,
      //     // ),
      //     // decoration: BoxDecoration(
      //     //   border: Border.all(color: Colors.grey[300], width: 1.0), //灰色的一层边框
      //     //   color: Colors.tealAccent,
      //     //   borderRadius: BorderRadius.all(Radius.circular(60)),
      //     // ),
      //   ),
      // ),