import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import '../Publics/AppStyle.dart';

class AppStyle {
  //全局样式
  static const Color mainColor = Color(0xFF07CD6C); // Colors.deepOrange;
  static const Color mainBackgroundColor = Color(0xFFEDEDED);
  static const Color clTitleBC = Color(0xFFEDEDED);
  static const Color bottomBackgroundColor = Color(0xFFF8F8F8);
  static const Color clSplitterLineColor = Color(0xFFE3E3E3);
  static const Color mainTitle1Color = Color(0xFF313031);
  static Color mainTitle2Color = Color(0xFF4A4A4A);
  static Color mainTitle3Color = Color(0xFF4A4A4A);
  static Color lightColor = Color(0xFFABABAB);
  static Color clButtonGray = Colors.black54;
  static Color clSaveButtonBC = Colors.blueAccent;
  static Color clCancelButtonBC = Colors.redAccent;
  static const Color clTFBorder = Color(0xFFABABAB);
static const Color clAssertIcon = Color(0xFFE0E0E0);  //grey[300]
static const Color clBorderImage = Color(0xFFE0E0E0);//grey[200]
static const Color clBorderImage1 = Color(0xFFBDBDBD);//grey[400]
  static const Color clTitle1FC = Color(0xFF191919);
  static const Color clTitle2FC = Color(0xFF7F7F7F);
  static double articalTitleFontSize = 19;

  static double articalSubTitleFontSize = 17.0;

  static Color articalContentColor = Color(0xFF414141);
  static double articalContentFontSize = 17.2;

  static double mainIconButtonSize = 24.0;

  static double popupDialogButtonSize = 18.5;

  static double paddingHorz = 40.0;
  static int pagesize = 10;

  static double clickedTextSize = 17.0;
  static Color clickedTextColor = Colors.blueAccent;

  static Color iosPopupTitleColor = Color(0xFF010102);
  static Color iosPopupContentColor = Color(0xFF363536);
  static Color iosPopupButtontColor = Color(0xFF307FE8);

  //Cupertino 弹窗字体
  static const double dialogCornerRadius = 14.0;
  static const String ffPF = '.SF UI Display';

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
  );

  static const TextStyle fsCupertinoDialogActionStyle = TextStyle(
    fontFamily: '.SF UI Text',
    inherit: false,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    color: CupertinoColors.systemBlue,
  );

  static const TextStyle titleTextStyle = TextStyle(
    color: AppStyle.clTitle2FC,
    fontSize: 16.5,
  );

  //字体大小
  static double dTitleText = 18.0;
  static double dEditText = 17.0;

  //全宽按钮高度
  static double dButtonHeight = 45.0;

  //主板运行颜色
  static Color cpCloseColor = Colors.grey[400];
  static Color cpOpenColor = Colors.green[300]; //Color(0xFF007046);
  static const Color cpClockColor = Colors.red;
  static final Color cpSteamColor = Colors.brown;

  static TextStyle clickedText() {
    return TextStyle(
      fontSize: clickedTextSize,
      color: clickedTextColor,
      decoration: TextDecoration.underline,
    );
  }

  static Size screenSize;

  //全局参数
  static double appBarDiff = 0.085;

  static getAppBarHeight() {
    return Size.fromHeight(screenSize.height * appBarDiff);
  }

//   size ： 一个包含宽度和高度的对象，单位是dp
// print(MediaQuery.of(context).size);
// devicePixelRatio : 返回设备的像素密度
// print(MediaQuery.of(context).devicePixelRatio);
// 获取上边距和下边距的值。(主要用于刘海屏)
//   final double topPadding = MediaQuery.of(context).padding.top;
// final double bottomPadding = MediaQuery.of(context).padding.bottom;
// 需要注意的是：
// 上边距在 iPhoneX 上的值是 44， 在其他设备上的值是 20， 是包含了电池条的高度的。
// 下边距在iPhoneX 上的值是34，在其他设备上的值是 0。
}
