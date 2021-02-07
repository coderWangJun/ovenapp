import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '聪锋智能烤炉系统',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '聪锋智能烤炉系统 V0.1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//进度条
/*
Container(
              padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
              child: LinearProgressIndicator(
                value: 0.3,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                backgroundColor: Color(0xff00ff00),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
              child: Container(
                height: 10.0,
                child: LinearProgressIndicator(
                  value: 0.3,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  backgroundColor: Color(0xff00ff00),
                ),
              ),
            ),
        Container(
              padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
              child: LinearProgressIndicator(
//                    value: 0.3,
                backgroundColor: Color(0xffff0000),
              ),
            ),
        Container(
              padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
              child: LinearProgressIndicator(
                value: 0.3,
                backgroundColor: Color(0xff00ff00),
              ),
            ),
        CircularProgressIndicator(
          strokeWidth: 4.0,
          backgroundColor: Colors.blue,
// value: 0.2,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
        ),

        CircularProgressIndicator(
//                    value: 0.3,
                    backgroundColor: Color(0xffff0000),
                  ),
              
              CircularProgressIndicator(
                    value: 0.3,
                    backgroundColor: Color(0xffff0000),
                  ),
              CircularProgressIndicator(
//                    value: 0.3,
                    strokeWidth: 4.0,
                    backgroundColor: Color(0xffff0000),
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                  CircularProgressIndicator(
//                    value: 0.3,
                    strokeWidth: 8.0,
                    backgroundColor: Color(0xffff0000),
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                  CircularProgressIndicator(
//                    value: 0.3,
                      backgroundColor: Color(0xffff0000),
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
*/

//stream builder 局部更新
/*

 // int _counter = 0;
  // final StreamController<int> _streamController = StreamController<int>();

  @override
  void initState() {
    super.initState();
    print("@@@ => MyPage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();
    print("@@@ MyPage.dispose() ...");
  }


// IconButton(
          //     icon: Icon(Icons.search),
          //     onPressed: () {
          //       Navigator.of(context).pushNamed("/login");
          //     }),
          // Center(
          //   child: StreamBuilder<int>(
          //       // 监听Stream，每次值改变的时候，更新Text中的内容
          //       stream: _streamController.stream,
          //       initialData: _counter,
          //       builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          //         return Text('You hit me: ${snapshot.data} times');
          //       }),
          // ),

// floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     // 每次点击按钮，更加_counter的值，同时通过Sink将它发送给Stream；
      //     // 每注入一个值，都会引起StreamBuilder的监听，StreamBuilder重建并刷新counter
      //     _streamController.sink.add(++_counter);
      //   },
      // ),
*/