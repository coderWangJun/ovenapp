import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Pages/PrivateTextPage.dart';

class PrivateServicePage extends StatefulWidget {
  @override
  _PrivateServicePageState createState() => _PrivateServicePageState();
}

class _PrivateServicePageState extends State<PrivateServicePage> {
  String privateStr1 =
      '请你务必审慎阅读、充分理解“服务协议”和“隐私政策”各条款，包括但不限于：为了向你提供即时通讯、内容分享等服务，我们需要收集你的设备信息、操作日志等个人信息。你可以在“设置”中查看、变更、删除个人信息并管理你的授权。你可阅读';
  String privateStr2 = '了解详细信息。如你同意，请点击“同意”开始接受我们的服务。';

  // List<ActionButtonModel> _lstAB = [];
  // _lstAB.add(
  //     ActionButtonModel(id: 0, title: '暂不使用', foreColor: Colors.black87));
  // _lstAB.add(ActionButtonModel(
  //     id: 1, title: '同意')); //,foreColor: CupertinoColors.systemBlue

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                height: 50.0,
                // color: Colors.deepPurpleAccent,
                child: Text(
                  '服务协议和隐私政策',
                  style: TextStyle(color: Colors.black, fontSize: 22.0),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: RichText(
                    text: TextSpan(
                        // style: DefaultTextStyle.of(context).style,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0,
                            fontFamily: '.SF UI Text'),
                        children: <InlineSpan>[
                          TextSpan(text: privateStr1),
                          TextSpan(
                            text: '《服务协议》',
                            style: TextStyle(color: Colors.blue[300]),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print(
                                    "@@@ AboutPage => _showPrivate.TapGestureRecognizer 《服务协议》");
                                _showAgreement(context, 0);
                              },
                          ),
                          TextSpan(text: '和'),
                          TextSpan(
                            text: '《隐私政策》',
                            style: TextStyle(color: Colors.blue[300]),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print(
                                    "@@@ AboutPage => _showPrivate.TapGestureRecognizer 《隐私政策》");
                                _showAgreement(context, 1);
                              },
                          ),
                          TextSpan(text: privateStr2),
                        ]),
                  ),
                ),
              ),
              Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              Container(
                height: 50.0,
                // color: Colors.redAccent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: FlatButton(
                            child: Text(
                              '暂不使用',
                              style: TextStyle(
                                fontFamily: '.SF UI Text',
                                inherit: false,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                textBaseline: TextBaseline.alphabetic,
                                color: Colors.black87,
                              ),
                            ),
                            onPressed: () {
                              _exitApp();
                            },
                          ),
                        )),
                    Container(
                      height: double.infinity,
                      width: 1.0,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: FlatButton(
                            child: Text(
                              '同意',
                              style: TextStyle(
                                fontFamily: '.SF UI Text',
                                inherit: false,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                textBaseline: TextBaseline.alphabetic,
                                color: CupertinoColors.systemBlue,
                              ),
                            ),
                            onPressed: () {
                              _goOn();
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  _exitApp() {
    print("@@@ => PrivateServicePage._exitApp() ... ");
    SystemNavigator.pop();
// exit(0);
  }

  _goOn() {
    print("@@@ => PrivateServicePage._goOn() ... ");
    SharePrefHelper.saveData("privateprotect", 'agreed');
    Navigator.of(context).pushReplacementNamed("/maintab");
    //  Navigator.of(context).pop(1);
  }

  _showAgreement(context, pt) {
    print("@@@ => PrivateServicePage._showService($pt) ... ");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PrivateTextPage(
                  tt: pt,
                )));
  }
}
