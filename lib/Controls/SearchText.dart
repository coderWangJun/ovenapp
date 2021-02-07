import 'package:flutter/material.dart';

///搜索控件widget
class SearchText extends StatelessWidget {
  Widget buildTextField() {
    //theme设置局部主题
    return TextField(
      cursorColor: Colors.white, //设置光标
      decoration: InputDecoration(
          //输入框decoration属性
//            contentPadding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 1.0),
          contentPadding: new EdgeInsets.only(left: 0.0),
//            fillColor: Colors.white,
          border: InputBorder.none,
           icon: Icon(Icons.search),
//            icon: ImageIcon(AssetImage("image/search_meeting_icon.png",),),
          // icon: ImageIcon(
          //   AssetImage(
          //     "image/search.png",
          //   ),
          // ),
          hintText: "设备名称",

          hintStyle: new TextStyle(fontSize: 14, color: Colors.white)),
      style: new TextStyle(fontSize: 14, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget editView() {
      return Container(
        //修饰黑色背景与圆角
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.0), //灰色的一层边框
          color: Colors.grey,
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        ),
        alignment: Alignment.center,
        height: 36,
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        child: buildTextField(),
      );
    }

    var cancleView = new Text("cancle");

    return editView();

  }
}