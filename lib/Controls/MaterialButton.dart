import 'package:flutter/material.dart';
import 'package:ovenapp/Models/MaterialModel.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';

class HomeMaterialButton extends StatelessWidget {
  // HomeMaterialButton({this.id, this.title, this.callback});
  HomeMaterialButton({this.materialModel});

  final MaterialModel materialModel;
  final _iconsize = 50.0;
  // final String id;
  // final String title;
  // final callback;

  @override
  Widget build(BuildContext context) {
// int id=materialModel.id;

    return Expanded(
        child: GestureDetector(
            onTap: () {
              print("id : " + materialModel.id.toString());
              // _gotoDemo(context, id);
            },
            child: new Container(
              // decoration: new BoxDecoration(
              //   border: new Border.all(width: 1.0, color: Colors.black45),
              //   borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              // ),
              // color: Colors.deepOrangeAccent,
              alignment: Alignment.center,
              // margin: new EdgeInsets.all(1.5),
              height: 80.0,
              // width: 60.0,
              child: new Column(children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: Center(
                    // child: _getIcon(materialModel.id.toString()), //Icon(_getIcon(id)),
                    child: Image (
                        image: AssetImage("images/"+materialModel.mainpic),
                        width: _iconsize,
                        height: _iconsize,
                        ),
                  ),
                ),
                new Expanded(
                  child: Text(
                    materialModel.name,
                    style: new TextStyle(fontSize: 17, color: Colors.black87),
                    textScaleFactor: 1.0,
                  ),
                ),
              ]),
            )));
  }

  void onchildcall(String value) {
    print("@@@ => onCallback.value => " + value);
  }

  // _getIcon(String id) {
  //   switch (id) {
  //     case "menu":
  //       return new Icon(
  //         Icons.airplay,
  //         color: Colors.indigo,
  //         size: _iconsize,
  //       ); //"images/ic_home_normal.png";
  //       break;
  //     case "food":
  //       return new Icon(
  //         Icons.bluetooth,
  //         color: Colors.indigo,
  //         size: _iconsize,
  //       ); //Icons.bluetooth; //"images/ic_msg_normal.png";
  //       break;
  //     case "class":
  //       return new Icon(
  //         Icons.headset,
  //         color: Colors.indigo,
  //         size: _iconsize,
  //       ); //Icons.headset; //"images/ic_my_normal.png";
  //       break;
  //     case "vedio":
  //       return new Icon(
  //         Icons.palette,
  //         color: Colors.indigo,
  //         size: _iconsize,
  //       ); //Icons.palette; //"images/ic_shop_normal.png";
  //       break;
  //   }
  // }
}

class HomeNullMaterialButton extends StatelessWidget {
  // HomeMaterialButton({this.id, this.title, this.callback});
  // HomeMaterialButton({this.materialModel});
  HomeNullMaterialButton({this.id});
  final _iconsize = 50.0;
  final String id;
  // final String title;
  // final callback;
  final _lstButtonTitle = {
    "material": "烘培原料",
    "appliance": "烘培器具",
    "school": "烘培学院",
    "machine": "烘培机器",
    "ai": "烘培智能",
    "package": "烘培包装"
  };

  //   new MenuButton(
  //       id: "material", title: "烘培原料", callback: (val) => onchildcall(val)),
  //   new MenuButton(
  //       id: "utensil", title: "烘培器具", callback: (val) => onchildcall(val)),
  //   new MenuButton(
  //       id: "school", title: "烘培学院", callback: (val) => onchildcall(val)),
  //   new MenuButton(
  //       id: "machine", title: "烘培机器", callback: (val) => onchildcall(val)),
  //   new MenuButton(
  //       id: "ai", title: "烘培智能", callback: (val) => onchildcall(val)),
  //   new MenuButton(
  //       id: "package", title: "烘培包装", callback: (val) => onchildcall(val)),
  // ];

  @override
  Widget build(BuildContext context) {
// int id=materialModel.id;

    return Expanded(
        child: GestureDetector(
            onTap: () {
              print("id : " + id);
              // _gotoDemo(context, id);
            },
            child: Container(
              // decoration: new BoxDecoration(
              //   border: new Border.all(width: 1.0, color: Colors.black45),
              //   borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              // ),
              // color: Colors.deepOrangeAccent,
              alignment: Alignment.center,
              // margin: new EdgeInsets.all(1.5),
              height: 80.0,
              // width: 60.0,
              child: Column(children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Image (
                        image: AssetImage("images/"+id+".png"),
                        width: _iconsize,
                        height: _iconsize,
                        ),),
                        Container(height: 3,),
                Expanded(
                  child: Text(
                    _lstButtonTitle[id],
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ]),
            )));
  }

  void onchildcall(String value) {
    print("@@@ => onCallback.value => " + value);
  }

// {"material":"烘培原料","utensil": "烘培器具","school": "烘培学院","machine": "烘培机器","ai": "烘培智能","package": "烘培包装"};
  // _getIcon(String id) {
  //   switch (id) {
  //     case "material":
  //       return new Icon(
  //         Icons.airplay,
  //         color: Colors.indigo,
  //         size: _iconsize,
  //       ); //"images/ic_home_normal.png";
  //       break;
  //     case "utensil":
  //       return new Icon(
  //         Icons.bluetooth,
  //         color: Colors.indigo,
  //         size: _iconsize,
  //       ); //Icons.bluetooth; //"images/ic_msg_normal.png";
  //       break;
  //     case "school":
  //       return new Icon(
  //         Icons.headset,
  //         color: Colors.indigo,
  //         size: _iconsize,
  //       ); //Icons.headset; //"images/ic_my_normal.png";
  //       break;
  //     case "machine":
  //       return new Icon(
  //         Icons.palette,
  //         color: Colors.indigo,
  //         size: _iconsize,
  //       ); //Icons.palette; //"images/ic_shop_normal.png";
  //       break;
  //     case "ai":
  //       return new Icon(
  //         Icons.palette,
  //         color: Colors.indigo,
  //         size: _iconsize,
  //       ); //Icons.palette; //"images/ic_shop_normal.png";
  //       break;
  //     case "package":
  //       return new Icon(
  //         Icons.palette,
  //         color: Colors.indigo,
  //         size: _iconsize,
  //       ); //Icons.palette; //"images/ic_shop_normal.png";
  //       break;
  //   }
  // }
}
