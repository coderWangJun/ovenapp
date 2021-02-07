import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:ovenapp/Publics/AppStyle.dart';

class AppDiaglogHelper {
  //Cupertino 弹窗字体
  static const double dialogCornerRadius = 14.0;
  static const Color clSplitterLine = Color(0xFFBDBDBD);
  static const double dSplitterWidth = 0.5;

  static const TextStyle fsCupertinoDialogTitleStyle = TextStyle(
    fontFamily: '.SF UI Display',
    inherit: false,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.48,
    textBaseline: TextBaseline.alphabetic,
    color: CupertinoColors.systemRed,
  );

  static const TextStyle fsCupertinoDialogContentStyle = TextStyle(
    fontFamily: '.SF UI Text',
    inherit: false,
    fontSize: 13.4,
    fontWeight: FontWeight.w400,
    height: 1.036,
    letterSpacing: -0.25,
    textBaseline: TextBaseline.alphabetic,
    color: CupertinoColors.systemBlue,
  );

  static const TextStyle fsCupertinoDialogActionStyle = TextStyle(
    fontFamily: '.SF UI Text',
    inherit: false,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    color: CupertinoColors.systemBlue,
  );

  //全列表文字样式
  static const TextStyle fsCupertinoDialogListTextStyle = TextStyle(
    fontFamily: '.SF UI Text',
    inherit: false,
    fontSize: 20.0,
    // fontWeight: FontWeight.w400,.systemBlue
    textBaseline: TextBaseline.alphabetic,
    color: CupertinoColors.systemBlue,
  );

  //取消按钮的文字样式
  static const TextStyle fsCupertinoDialogCancelTextStyle = TextStyle(
    fontFamily: '.SF UI Text',
    inherit: false,
    fontSize: 20.0,
    // fontWeight: FontWeight.w400,.systemBlue
    textBaseline: TextBaseline.alphabetic,
    color: CupertinoColors.systemRed,
  );
  // static const TextStyle titleTextStyle = TextStyle(
  //   color: AppStyle.clTitle2FC,
  //   fontSize: 16.5,
  // );

  //带确定取消的单个输入框   String title,
  static showTextFieldDialog(BuildContext context, TitleTextModel ttm) {
    final TextEditingController textController =
        TextEditingController(text: "");
    return showDialog<String>(
        context: context,
        // barrierDismissible: true,  //点击空白处可以退出对话框
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.5,
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(dialogCornerRadius),
            ),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // backgroundColor: Colors.deepOrangeAccent,
            title: _getTitle(ttm),
            children: <Widget>[
              //文本内容
              Container(
                padding: EdgeInsets.fromLTRB(
                  20.0,
                  12.0,
                  20.0,
                  12.0,
                ),
                child: CupertinoTextField(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  controller: textController,
                  autofocus: true,
                  // keyboardType: TextInputType.number,
                  // maxLength: 3,
                  style: TextStyle(color: Colors.black45, fontSize: 18.0),
                  textAlign: TextAlign.center,
                  //输入完成时调用
                  // onEditingComplete: () {
                  //   if (num.parse(tempController.text) > 600) {
                  //     tempController.text = '600';
                  //   }
                  // },
                ),
                // color: Colors.green[200],
              ),

              //按钮组
              Container(
                height: 50.0,
                margin: EdgeInsets.only(top: 15.0),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: clSplitterLine,
                    width: dSplitterWidth,
                  )), //灰色的一层边框
                  // border:
                  //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                  // color: Colors.white,
                  // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                // color: Colors.tealAccent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _getReturnButtonUI(context, '取消', 0,
                          textController, CupertinoColors.systemGrey2),
                    ),
                    Container(
                      height: double.infinity,
                      width: dSplitterWidth,
                      color: clSplitterLine,
                    ),
                    Expanded(
                      child:
                          _getReturnButtonUI(context, '确定', 1, textController),
                      // _getReturnButtonUI(() {
                      //   Navigator.of(context).pop(textController.text.trim());
                      // }, '确定', 1, Colors.redAccent),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  //文本选择项列表
  static showSelectTextList(BuildContext context, List<String> lstItem,
      [int cancel = 0, int cancelvalue = -999, double itemHeight = 60.0]) {
    return showDialog<int>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.2,
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(dialogCornerRadius),
            ),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // backgroundColor: Colors.deepOrangeAccent,
            // title: _getTitle(ttm),
            children:
                _getTextItem(context, lstItem, itemHeight, cancel, cancelvalue),
            // <Widget>[
            // _lst,
            // ],
          );
        });
    // showCupertinoDialog(
    //     context: context,
    //     builder: (context) {
    //       return CupertinoAlertDialog(
    //         // barrierDismissible:false,
    //         content: Column(
    //           children: _getTextItem(context, lstItem, 60.0),
    //         ),
    //       );
    //     });
  }

  static _getTextItem(context, lstItem, lineHeight, cancel, cancelvalue) {
    //cancel为1时自动加Cancel选项
    var _lst = <Widget>[];
    for (int i = 0; i < lstItem.length; i++) {
      var g = GestureDetector(
        child: Container(
          // color: Colors.cyanAccent,
          height: lineHeight,
          width: double.infinity,
          alignment: Alignment.center,
          // color: Colors.orangeAccent,
          child: Text(
            lstItem[i],
            style:
                fsCupertinoDialogListTextStyle, //TextStyle(color: Colors.blue[400], fontSize: 18.0),
          ),
        ),
        onTap: () {
          // if (callback != null) callback(i.toString());
          // Navigator.pop(context);
          Navigator.of(context).pop(i);
        },
      );
      _lst.add(g);
      if (i != (lstItem.length - 1)) {
        _lst.add(Container(
          height: 0.5,
          color: Colors.grey[400],
        ));
      }
    }

    if (cancel == 1) {
      _lst.add(Container(
        height: 0.5,
        color: Colors.grey[400],
      ));

      _lst.add(GestureDetector(
        child: Container(
          // color: Colors.cyanAccent,
          height: lineHeight,
          width: double.infinity,
          alignment: Alignment.center,
          // color: Colors.orangeAccent,
          child: Text(
            '取消',
            style:
                fsCupertinoDialogCancelTextStyle, //TextStyle(color: Colors.blue[400], fontSize: 18.0),
          ),
        ),
        onTap: () {
          // if (callback != null) callback(i.toString());
          // Navigator.pop(context);
          Navigator.of(context).pop(cancelvalue);
        },
      ));
    }
    return _lst;
  }

  //带多个按钮的整块文本内容显示
  static showRichTextButtonsDialog(BuildContext context, TitleTextModel ttm,
      RichText richText, List<ActionButtonModel> lstButton) {
    return showDialog<int>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.2,
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(dialogCornerRadius),
            ),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // backgroundColor: Colors.deepOrangeAccent,
            title: _getTitle(ttm),
            children: _getRichTextUI(context, richText, lstButton),
            // <Widget>[
            // _lst,
            // ],
          );
        });
  }

//底部带多个按钮的纯列表文本显示
  static showTitleTextButtonsDialog(BuildContext context, TitleTextModel ttm,
      List<ContentTextModel> lstText, List<ActionButtonModel> lstButton) {
    return showDialog<int>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.2,
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(dialogCornerRadius),
            ),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // backgroundColor: Colors.deepOrangeAccent,
            title: _getTitle(ttm),
            children: _getContentUI(context, lstText, lstButton),
            // <Widget>[
            // _lst,
            // ],
          );
        });
  }

  //是否对话框，0取消 否，1确定 是
  static showYesNoDialog(BuildContext context, String title,
      [Color clYes = CupertinoColors.systemBlue,
      Color clNo = CupertinoColors.systemGrey]) {
    return showDialog<int>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.5,
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(dialogCornerRadius),
            ),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // backgroundColor: Colors.deepOrangeAccent,
            // title: _getTitle(ttm),
            children: <Widget>[
              //文本内容
              Container(
                child: Text(
                  title,
                  style: //fsCupertinoDialogContentStyle,
                      TextStyle(
                    color: Colors.black87,
                    fontSize: 18.5,
                    fontFamily: '.SF UI Text',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: 0.2,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
                margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
                // color: Colors.green[200],
              ),

              //按钮组
              Container(
                height: 50.0,
                margin: EdgeInsets.only(top: 15.0),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                  // border:
                  //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                  // color: Colors.white,
                  // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                // color: Colors.tealAccent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _getButtonUI(() {
                        Navigator.of(context).pop(0);
                      }, '否', 0, clNo),
                    ),
                    Container(
                      height: double.infinity,
                      width: dSplitterWidth,
                      color: clSplitterLine,
                    ),
                    Expanded(
                      child: _getButtonUI(() {
                        Navigator.of(context).pop(1);
                      }, '是', 1, clYes),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  static _getRichTextUI(BuildContext context, RichText richText,
      List<ActionButtonModel> lstButton) {
    List<Widget> _lst = []; // _getUpdateText(context, lstText);
    _lst.add(
      Container(
        child: richText,
        margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      ),
    );
    _lst.add(_getButtonsUI(context, lstButton));
    return _lst;
  }

  static _getContentUI(BuildContext context, List<ContentTextModel> lstText,
      List<ActionButtonModel> lstButton) {
    List<Widget> _lst = []; // _getUpdateText(context, lstText);
    _lst.add(_getTextsUI(context, lstText));
    _lst.add(_getButtonsUI(context, lstButton));
    return _lst;
  }

  static _getTextsUI(BuildContext context, List<ContentTextModel> lstText) {
    List<Widget> _lst = [];
    // for (int i = 0; i < lstText.length; i++) {
    lstText.forEach((ctm) {
      // print(
      //     "@@@ => AppDiaglogHelper._getTextsUI i : $i , lstText[i] : ${lstText[i]}");
      _lst.add(Container(
        // color: Colors.cyanAccent,
        height: 30.0,
        width: double.infinity,
        margin: EdgeInsets.only(left: 25.0),
        alignment: Alignment.centerLeft,
        // color: Colors.orangeAccent,
        child: Text(
          ctm.text,
          style: TextStyle(color: ctm.foreColor, fontSize: ctm.fontSize),
          textAlign: TextAlign.left,
        ),
      ));
    });

    return Column(children: _lst);
  }

  static _getButtonsUI(
      BuildContext context, List<ActionButtonModel> lstButton) {
    List<Widget> _lst = [];
    int ii = 0;
    lstButton.forEach((abm) {
      // print("@@@ => AboutPage._getButtonsUI abm.foreColor : ${abm.foreColor}");
      // print(
      //     "@@@ => AboutPage._getButtonsUI abm.backgroundColor : ${abm.backgroundColor}");
      // if (ii == 0) {
      //添加按钮
      _lst.add(Expanded(
        child: _getButtonUI(() {
          Navigator.of(context).pop(abm.id);
        },
            abm.title,
            _getActionButtonPosition(lstButton.length, ii),
            // ii == 0 ? 0 : (ii == (lstButton.length - 1) ? 1 : 2),
            abm.foreColor,
            // Colors.red,
            abm.backgroundColor),
      ));
      // }
      ii++;
      //添加分隔线
      if (ii < lstButton.length) {
        _lst.add(Container(
          height: double.infinity,
          width: dSplitterWidth,
          color: clSplitterLine,
        ));
      }
    });

    return Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                color: Colors.grey[400], width: dSplitterWidth)), //灰色的一层边框
        // border:
        //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
        // color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      // color: Colors.tealAccent,
      child: Row(
        children: _lst,
      ),
    );
  }

  static _getActionButtonPosition(len, ii) {
    if (len == 1) return 2;
    if (ii == 0) {
      return 0;
    } else {
      if (ii == (len - 1))
        return 1;
      else
        return 9;
    }
  }

  static _getTitle(TitleTextModel ttm) {
    return Container(
      alignment: Alignment.bottomCenter,
      // color: Colors.cyanAccent,
      // margin:
      //     EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),
      padding: EdgeInsets.only(top: 0.0, bottom: 15.0, left: 0.0),
      height: 60.0,
      child: Text(
        ttm.text,
        style: _getTitleStyle(ttm.fontSize, ttm.foreColor),
        // style: TextStyle(
        //   fontSize: 18.0,
        //   color: Colors.black87,
        //   fontWeight: FontWeight.normal,
        // ),
      ),
      decoration: BoxDecoration(
        // border: Border(
        //   bottom: BorderSide(color: Colors.grey[400], width: 1.0),
        // ), //灰色的一层边框
        // border:
        //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
        // color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(dialogCornerRadius)),
      ),
    );
  }

//position 位置，0左，1中，2右
  static _getButtonUI(callback, textStr, position,
      [Color foreColor = CupertinoColors.systemBlue,
      Color backGroudColor = Colors.transparent]) {
    return GestureDetector(
      child: Container(
        // clipBehavior: Clip.none,
        // color: Colors.green[300],
        alignment: Alignment.center,
        height: double.infinity,
        decoration: BoxDecoration(
          // borderRadius:BorderRadius.all(Radius.circular(10.0)), //设定 Card 的倒角大小
          borderRadius: _getRadius(position),
          // BorderRadius.only(
          //   //   //设定 Card 的每个角的倒角大小
          //   //   topLeft: Radius.zero, //Radius.circular(20.0),
          //   //   topRight: Radius.zero,
          //   //   bottomLeft: Radius.zero, //Radius.circular(10.0),
          //   bottomRight: Radius.circular(dialogCornerRadius),
          // ),
          color: backGroudColor,
        ),
        child: Text(
          textStr,
          // textAlign: TextAlign.center,
          style: _getActionStyle(foreColor), //fsCupertinoDialogActionStyle,//
          // TextStyle(
          //   color: Colors.black87,
          //   fontSize: 16.0,
          // ),
        ),
      ),
      onTap: () {
        // Navigator.of(context).pop();
        callback();
      },
    );
  }

//非事件回调，直接返回按钮
  static _getReturnButtonUI(context, textStr, position, textController,
      [Color foreColor = CupertinoColors.systemBlue,
      Color backGroudColor = Colors.transparent]) {
    return GestureDetector(
      child: Container(
        // clipBehavior: Clip.none,
        // color: Colors.green[300],
        alignment: Alignment.center,
        height: double.infinity,
        decoration: BoxDecoration(
          // borderRadius:BorderRadius.all(Radius.circular(10.0)), //设定 Card 的倒角大小
          borderRadius: _getRadius(position),
          // BorderRadius.only(
          //   //   //设定 Card 的每个角的倒角大小
          //   //   topLeft: Radius.zero, //Radius.circular(20.0),
          //   //   topRight: Radius.zero,
          //   //   bottomLeft: Radius.zero, //Radius.circular(10.0),
          //   bottomRight: Radius.circular(dialogCornerRadius),
          // ),
          color: backGroudColor,
        ),
        child: Text(
          textStr,
          // textAlign: TextAlign.center,
          style: _getActionStyle(foreColor), //fsCupertinoDialogActionStyle,//
          // TextStyle(
          //   color: Colors.black87,
          //   fontSize: 16.0,
          // ),
        ),
      ),
      onTap: () {
        if (position == 1) {
          if (textController.text.trim() == "") return;
          Navigator.of(context).pop(textController.text);
        } else
          Navigator.of(context).pop(null);
        // callback();
      },
    );
  }

  static _getRadius(position) {
    switch (position) {
      case 0:
        return BorderRadius.only(
          //   topLeft: Radius.zero, //Radius.circular(20.0),
          //   topRight: Radius.zero,
          //   bottomLeft: Radius.zero, //Radius.circular(10.0),
          bottomLeft: Radius.circular(dialogCornerRadius),
        );
        break;
      case 1:
        return BorderRadius.only(
          //   topLeft: Radius.zero, //Radius.circular(20.0),
          //   topRight: Radius.zero,
          //   bottomLeft: Radius.zero, //Radius.circular(10.0),
          bottomRight: Radius.circular(dialogCornerRadius),
        );
        break;
      case 2:
        return BorderRadius.only(
          //   topLeft: Radius.zero, //Radius.circular(20.0),
          //   topRight: Radius.zero,
          bottomLeft: Radius.circular(dialogCornerRadius),
          bottomRight: Radius.circular(dialogCornerRadius),
        );
        break;
      default:
        {
          return BorderRadius.all(
            Radius.zero,
          );
        }
        break;
    }
  }

  static _getTitleStyle([fontSize = 20.0, foreColor = Colors.black87]) {
    return TextStyle(
      fontFamily: '.SF UI Display',
      inherit: false,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.48,
      textBaseline: TextBaseline.alphabetic,
      color: foreColor, //CupertinoColors.systemRed,
    );
  }

  static _getActionStyle(
      [fontColor = CupertinoColors.systemBlue, fontSize = 18.0]) {
    // print("@@@ => AboutPage._getActionStyle fontColor : $fontColor");
    return TextStyle(
      fontFamily: '.SF UI Text',
      inherit: false,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      color: fontColor,
    );
  }
}

class ActionButtonModel {
  int id;
  int position = 2;
  String title;
  Color backgroundColor =
      Colors.transparent; //此处类初始化并不会赋该值，除非在类构造函数里面移去该成员的定义，否则会为null值
  Color foreColor = CupertinoColors.systemBlue;
//ActionButtonModel abm=ActionButtonModel(); 此种形式的初始化则会保留以上默认值 ；
  ActionButtonModel({
    this.id,
    this.position,
    this.title,
    this.backgroundColor = Colors.transparent,
    this.foreColor = CupertinoColors.systemBlue,
  }) : super();

  toJsonStr() {
    return '{"id":"${this.id}",'
        '"position":"${this.position}",'
        '"title":"${this.title}",'
        '"backgroundColor":"${this.backgroundColor}",'
        '"foreColor":"${this.foreColor}",'
        '}';
  }
}

class ContentTextModel {
  String text;
  double fontSize = 18.0;
  // Color backgroundColor = Colors.transparent;
  //此处类初始化并不会赋该值，除非在类构造函数里面移去该成员的定义，否则会为null值
  Color foreColor = CupertinoColors.systemGrey2;
//ActionButtonModel abm=ActionButtonModel(); 此种形式的初始化则会保留以上默认值 ；
  ContentTextModel({
    this.text,
    this.fontSize = 18.0,
    // this.backgroundColor= Colors.transparent,
    this.foreColor = CupertinoColors.systemGrey2,
  }) : super();

  toJsonStr() {
    return '"text":"${this.text}",'
        '"foreColor":"${this.foreColor}",'
        '"fontSize":"${this.fontSize}",'
        '}';
  }
}

class TitleTextModel {
  String text;
  double fontSize = 20.5;
  // Color backgroundColor = Colors.transparent;
  //此处类初始化并不会赋该值，除非在类构造函数里面移去该成员的定义，否则会为null值
  Color foreColor = Colors.black87;
//ActionButtonModel abm=ActionButtonModel(); 此种形式的初始化则会保留以上默认值 ；
  TitleTextModel({
    this.text,
    this.fontSize = 20.5,
    // this.backgroundColor= Colors.transparent,
    this.foreColor = Colors.black87,
  }) : super();

  toJsonStr() {
    return '"text":"${this.text}",'
        '"foreColor":"${this.foreColor}",'
        '"fontSize":"${this.fontSize}",'
        '}';
  }
}
