import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivateTextPage extends StatefulWidget {
  PrivateTextPage({Key key, this.tt}) : super(key: key);

  final int tt;

  @override
  _PrivateTextPage createState() => _PrivateTextPage();
}

// class _PrivateTextPage extends StatelessWidget {
class _PrivateTextPage extends State<PrivateTextPage> {
  String _title = '烘焙之光许可及服务协议';
  String _content = '';
  String _file = 'assets/res/ovenprivateguid.txt';
  String _url = 'https://www.cfdzkj.com/services.html';

  @override
  void initState() {
    super.initState();

    if (widget.tt == 1) {
      _title = '烘焙之光隐私保护指引';
      _file = 'assets/res/ovenserivceagreement.txt';
      _url = 'https://www.cfdzkj.com/private.html';
    }

    print("@@@ => PrivateTextPage.initState _title : $_title , _file : $_file");

    // _getContent();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if(tt==0)
    // title='烘焙之光许可及服务协议';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text(_title),
          elevation: 0.0,
          backgroundColor: Colors.greenAccent,
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: _url,
          );
        }
            // SingleChildScrollView(
            //   child: Container(
            //     height: MediaQuery.of(context).size.height,
            //     // child: RichText(
            //     //   text: _content,//TextSpan(text: _content),
            //     // ),
            //     //  child: WebView(
            //     //               initialUrl: newsModel.url,),
            //     child: Text(_content,softWrap: true,),
            //     // Stack(
            //     //   children: <Widget>[
            //     //     _getMainUI(),
            //     //   ],
            //     // ),
            //   ),
            // ),
            ),
      ),
    );
  }

  _getContent() async {
    _content = await rootBundle.loadString(_file);
    // _content='欢迎您使用杭州聪锋电子科技有限公司烘焙之光软件及服务！';
    print("@@@ => PrivateTextPage._getContent _content : $_content");
    setState(() {});
  }

//   Future<String> loadAsset() async {
//   return await rootBundle.loadString('assets/my_text.txt');
// }
  // String pt1 = '';
}
