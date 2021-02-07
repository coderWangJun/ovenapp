// import 'dart:async';

// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/DialogBO.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/MediaPlayer.dart';
// import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Models/SectionTimeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Services/EventBusSrv.dart';
// import 'package:audioplayers/audioplayers.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => new _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // int _counter = 0;
  // final StreamController<int> _streamController = StreamController<int>();

  // final AudioPlayer audioPlayer = AudioPlayer();
  String warnfile=GlobalVar.webimageurl+'m2.mp3';
  MediaPlayer mp;
  CachePlayer cachePlayer;
  @override
  void initState() {
    super.initState();
    mp=MediaPlayer((v){
      // print('@@@ onPlayerCompletion : $v');
      print('@@@ MediaPlayer.state : ${mp.getState()}');
      // mp.play(GlobalVar.webimageurl+ 'm2.mp3');
    });

    cachePlayer=CachePlayer();

    print("@@@ => ExplorePage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    mp.release();
    // _streamController.close();
    // audioPlayer.dispose();
    print("@@@ ExplorePage.dispose() ...");
  }

// class ExplorePage extends StatelessWidget {
  // final double _power=3.0;
  // final bool _isOpen=false;
  @override
  Widget build(BuildContext context) {
    print("@@@ ExplorePage.build() ...");

    return new Scaffold(
        appBar: new AppBar(
          leading: null,
          title: new Text('发现'),
        ),
        body: new SafeArea(
          child: new Column(children: <Widget>[
            new RaisedButton(
              child: new Text('Clear Local Storage'),
              onPressed: () {
                SharePrefHelper.clearData();
              },
            ),
            // new RaisedButton(
            //   child: new Text('user info'),
            //   onPressed: () {
            //     _p();
            //   },
            // ),
            // new RaisedButton(
            //   child: new Text('Type'),
            //   onPressed: () {
            //     SectionTimeModel st = SectionTimeModel.getEmptyObj();
            //     TemplateModel tm = TemplateModel.getNullObj();
            //     print(
            //         '@@@ SectionTimeModel.Type : ' + st.runtimeType.toString());
            //     print('@@@ TemplateModel.Type : ' + tm.runtimeType.toString());
            //   },
            // ),
            // new RaisedButton(
            //   child: new Text('Show Waitting Dialog'),
            //   onPressed: () {
            //     DialogBO.showWaitting(context);
            //   },
            // ),
            // new RaisedButton(
            //   child: new Text('Show Circle Dialog'),
            //   onPressed: () {
            //     DialogBO.showCircleWaitting(context);
            //   },
            // ),
            // RaisedButton(
            //   child: new Text('Show Willpop Circle'),
            //   onPressed: () {
            //     DialogBO.showCircleWait(context, 5);
            //   },
            // ),
            RaisedButton(
              child: new Text('Show showAudioWarn1'),
              onPressed: () {
                DialogBO.showAudioWarn1(context);
              },
            ),
            // RaisedButton(
            //   child: Text('Cache Play Audio'),
            //   onPressed: () {
            //   //  mp.play('file');
            //   cachePlayer.play('audios/m2.mp3');
            //   },
            // ),
            // RaisedButton(
            //   child: Text('Cache Play Loop'),
            //   onPressed: () {
            //    cachePlayer.loop('audios/m2.mp3');
            //   },
            // ),
            // RaisedButton(
            //   child: Text('Cache Stop'),
            //   onPressed: () {
            //    cachePlayer.stop();
            //   },
            // ),
            RaisedButton(
              child: Text('Play Url'),
              onPressed: () {
                print('@@@ ${GlobalVar.webimageurl+ 'm2.mp3'}');
               mp.play(GlobalVar.webimageurl+ 'm2.mp3');
              },
            ),
            RaisedButton(
              child: Text('Play local'),
              onPressed: () {                
               mp.playLocal('audios/m2.mp3');
              },
            ),
            RaisedButton(
              child: Text('Play Loop'),
              onPressed: () {                
               mp.loop(GlobalVar.webimageurl+ 'm2.mp3');
              },
            ),
             RaisedButton(
              child: Text('Play Stop'),
              onPressed: () {
               mp.stop();
              },
            ),
            RaisedButton(
              child: Text('spinkit'),
              onPressed: () {
                mp.loop(warnfile);
               DialogBO.showAudioWarn(context);
              },
            ),
             RaisedButton(
              child: Text('GlobalVar playWarnAudio'),
              onPressed: () {
              //   mp.loop(warnfile);
              //  DialogBO.showAudioWarn(context);
               GlobalVar.playWarnAudio(context,'05DAFF333136595043187617');
              },
            ),
            
            // new RaisedButton(
            //   child: new Text('dialog selector'),
            //   onPressed: () {
            //     AppDialog.showItemSelect2IOS(context, (item) {
            //       print("Your Choice : " + item);
            //     });
            //   },
            // ),
            // GestureDetector(
            //   child: Text(
            //     "张明月最近一直在加班，苦逼苦逼苦逼～～～",
            //     style: TextStyle(
            //         backgroundColor: Colors.redAccent, height: 1.5, fontSize: 15),
            //   ),
            //   onLongPress: () {},
            // ),
            // CupertinoSwitch(
            //               value: _isOpen,
            //               onChanged: (v) {
            //                 _isOpen = v;
            //                 print("_isOpen : " + _isOpen.toString());
            //               }),

            //   CupertinoSlider(
            //               // label: '$_power',
            //               value: _power,
            //               divisions: 5,
            //               max: 100,
            //               min: 0,
            //               onChanged: (v) {
            //                 _power = v;
            //                 print("_power : " + _power.toString());
            //               }),
          ]),
        ));
  }

  _p() async {
    String ui = await SharePrefHelper.getData("userinfo");
    print(ui);
  }  
}
