import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ovenapp/Classes/ApkHelper.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/IntroSlidePage.dart';
import 'package:ovenapp/Pages/PrivateServicePage.dart';
import 'package:ovenapp/Publics/AppRoutePath.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'Pages/MainTabPage.dart';
import 'Pages/NotFoundPage.dart';
import 'LoginPage.dart';

GlobalKey<NavigatorState> _navigatorKey = new GlobalKey();
bool _loginState = true;
// bool _privateState=false;
// Widget _launchWidget;

// int mainReducer(int state, dynamic action){
//   return state;
// }
// Store<int> store = new Store<int>(mainReducer,initialState: 0);
bool _isIntroSlideOK = false;
void main() async {
  print("@@@ main() ...");
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize();
  await ApkHelper.getAppVersion();
  await SharePrefHelper.initSP();
  await GlobalVar.initUserInfo();
  // GlobalVar.initMqttSrv();
  String sv = await SharePrefHelper.getData(GlobalVar.spintroslide);
  if (sv != '') _isIntroSlideOK = true;

  String pp = await SharePrefHelper.getData(GlobalVar.spprivateservice);
  if (pp != '') GlobalVar.hasreadprivateprotect = 1;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, //需要重新编译
    // showPerformanceOverlay:true, // 当为true时应用程序顶部覆盖一层GPU和UI曲线图，可即时查看当前流畅度情况
// resizeToAvoidBottomInset:false,

    locale: Locale('zh', 'cn'),
    theme: ThemeData(
      //主题色
      /*primarySwatch设置即可控制主题的各类颜色，但是这里的颜色是需要MaterialColor，但是纯色种的黑色和白色不是MaterialColor。所以不能设置primarySwatch为Colors.white。*/
      // primarySwatch: Colors.white,
      primaryColor: Colors.white,
      fontFamily: "LanTing",
      //此处设置所有按钮没有最小尺寸的限制，且内边距为0
      // buttonTheme: new ButtonThemeData(
      //       minWidth: 0,
      //       height: 0,
      //       padding: EdgeInsets.all(0),
      //       buttonColor: Colors.transparent
      //     ),
      // primarySwatch: MaterialColor(primary, swatch),Color(0xFF0cd1e8)
    ),
    color: AppStyle.clTitleBC, //该颜色为Android中程序切换中应用图标背景的颜色，当应用图标背景为透明时
    // builder: (BuildContext context, Widget child) {
    //   return MediaQuery(
    //     data: MediaQuery.of(context).copyWith(
    //       //字体大小
    //       textScaleFactor: 1,
    //     ),
    //     child: child,
    //   );
    // },
    // used by the OS task switcher 该标题出现在 Android：任务管理器的程序快照之上 IOS: 程序切换管理器中
    title: '聪锋智能烤炉',
    onGenerateTitle: (context) {
      //跟上面的tiitle一样，但含有一个context参数 用于做本地化
      return '聪锋智能烤炉';
    },

    // builder: (BuildContext context, Widget child) {
    //   print("ap => runApp.MaterialApp.builder");
    //   // 当构建一个Widget前调用，一般做字体大小，方向，主题颜色等配置
    // },
    // home: new MyScaffold(),
    home: AppScaffold(), //_getLaunchPage(),
    // home: _launchWidget,
    localizationsDelegates: [
      //此处
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      const FallbackCupertinoLocalisationsDelegate(),
    ],
    supportedLocales: [
      //此处
      const Locale('zh', 'CH'),
      const Locale('en', 'US'),
    ],

    navigatorKey: _navigatorKey,

    routes: appRoutePath,
    onGenerateRoute: generateRouteEvent,
    onUnknownRoute: (RouteSettings setting) {
      String name = setting.name;
      print("@@@ main.onUnknownRoute() => onUnknownRoute:$name");
      return new MaterialPageRoute(builder: (context) {
        return new NotFoundPage();
      });
    },

    // initialRoute: "/login",WebViewerPage
    // // onUnknownRoute:null, //效果跟onGenerateRoute一样 调用顺序为onGenerateRoute ==> onUnknownRoute
    navigatorObservers: [
      // MyObserver(),
    ],
  ));
// 那么状态栏的全透明沉浸呢，在main.dart 的runapp后面加上
//   SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
// SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

PageRouteBuilder generateRouteEvent(RouteSettings setting) {
  print("@@@ main.generateRouteEvent.setting.name : " + setting.name);
  //setting.isInitialRoute; bool类型 是否初始路由
  //setting.name; 要跳转的路由名key
  return new PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        //这里为返回的Widget
        return MyScaffold();
      },
      opaque: false,
      //跳转动画
      transitionDuration: new Duration(milliseconds: 200),
      transitionsBuilder:
          (___, Animation<double> animation, ____, Widget child) {
        return new FadeTransition(
          opacity: animation,
          child: new ScaleTransition(
            scale: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: child,
          ),
        );
      });

  //   final String name = settings.name;
  // final Function pageBuilder = this._routes[name];
  // if (pageBuilder != null) {
  //   if (settings.arguments != null) {
  //     // 如果透传了参数
  //     return MaterialPageRoute(
  //         builder: (context) =>
  //             pageBuilder(context, arguments: settings.arguments));
  //   } else {
  //     // 没有透传参数
  //     return MaterialPageRoute(builder: (context) => pageBuilder(context));
  //   }
  // }
  // return MaterialPageRoute(builder: (context) => HomeContent());
}

//返回启动页面
Widget _getLaunchPage() {
  // SharedPreferences prefs = SharedPreferences.getInstance();
  // print("getLaunchPage => 0");
  // _isLogined().then((b) {
  //   print("b => $b");
  //   // if (b)
  //   //   return new MainTabPage();
  //   // else
  //   //   return new LoginPage();
  // });
  // print("getLaunchPage => 1");

  print("@@@ main.getLaunchPage()._loginState => $_loginState");

  // return _launchWidget;

  if (_loginState)
    // return MainTabPage();
    return AppScaffold();
  else
    return LoginPage();
}

class AppScaffold extends StatelessWidget {
  // final int _customerStatelessText = 0;
  @override
  Widget build(BuildContext context) {
    // if (!isSrceen) {
    // GlobalVar.isSrceen = true;
    GlobalVar.getScreenSize(context);
    // }

    // ScreenUtil.init(context,
    //     width: 360, // GlobalVar.dScreenWidth,
    //     height: 592, // GlobalVar.dScreenHeight,
    //     allowFontScaling: true);
    ScreenUtil.init(context,
        designSize: Size(360, 592), allowFontScaling: true);
    // Material 是UI呈现的“一张纸”
    print(
        "@@@ main.AppScaffold.build => _isIntroSlideOK : $_isIntroSlideOK , GlobalVar.hasreadprivateprotect : ${GlobalVar.hasreadprivateprotect}");
    if (GlobalVar.hasreadprivateprotect == 0) {
      return PrivateServicePage();
      // Navigator.push(
      //   context, MaterialPageRoute(builder: (context) => PrivateServicePage()));
    }
    // SharePrefHelper.getData(GlobalVar.spintroslide).then((v){
    // if (_isIntroSlideOK) {
    return MainTabPage();
    // } else {
    //   return IntroSlidePage();
    // }
    // }).catchError((e){

    //   return MainTabPage();
    // });
  }
}

// _isLogined() async {
//   String islogin = "0";
//   await SharePrefHelper.getData("islogin").then((value) {
//     if (value == null) {
//       // print("**islogin => null");
//     } else {
//       // print("**islogin => " + value.toString());
//       islogin = "1";
//     }
//   });

//   if (islogin == "1") {
//     _loginState = true;
//     String sret = await SharePrefHelper.getData("userInfo"); //.then((value) {

//     Map<String, dynamic> ret = json.decode(sret);
//     UserModel um = UserModel();
//     GlobalVar.userInfo = um.fromJson(ret);

//     // print("userInfo => $value");
//     // userInfo = um;
//     // print("_isLogined().tk => " + GlobalVar.userInfo.tk);
//     // });
//   } else
//     _loginState = false;

//   print("@@@ main._isLogined()._loginState => $_loginState");

//   return _loginState;
// }

class MyScaffold extends StatelessWidget {
  // final int _customerStatelessText = 0;

  @override
  Widget build(BuildContext context) {
    // Material 是UI呈现的“一张纸”
    print("@@@ main.MyScaffold.build => child: new LoginPage()");
    return Material(
      // child: new LoginPage(),
      child: LoginPage(),
      // child: new HomePage(title:'aaa'),
      // Column is 垂直方向的线性布局.
    );
  }
}

//路由观察器，当调用Navigator的相关方法时，会回调相关的操作
class MyObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    //....等等
    print('@@@ main.MyObserver.didPush() route.settings.name => ' +
        route.settings.name);
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
// void main() => runApp(MyApp());
