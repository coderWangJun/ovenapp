import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class IntroSlidePage extends StatefulWidget {
  IntroSlidePage({Key key}) : super(key: key);

  @override
  _IntroSlidePageState createState() => _IntroSlidePageState();
}

// class _IntroSlidePageState extends IntroSlider {
class _IntroSlidePageState extends State<IntroSlidePage> {
  // IntroSlider introSlider;
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    SharePrefHelper.saveData(GlobalVar.spintroslide, 'OK');

    // introSlider = IntroSlider(
    //   slides: slides,
    // );

    slides.add(
      Slide(
        marginTitle: EdgeInsets.all(0.0),
        marginDescription: EdgeInsets.all(0.0),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        // widthImage: 400.0,
        // heightImage: 400.0,
        // title: "ERASER",
        // description:
        //     "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "images/downfire.png",
        backgroundImageFit: BoxFit.fill,
        // backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      Slide(
        marginTitle: EdgeInsets.all(0.0),
        marginDescription: EdgeInsets.all(0.0),
        // title: "PENCIL",
        // description:
        //     "Ye indulgence unreserved connection alteration appearance",
        pathImage: "images/upfire.png",
        backgroundColor: Color(0xff203152),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );
    slides.add(
      Slide(
        marginTitle: EdgeInsets.all(0.0),
        marginDescription: EdgeInsets.all(0.0),
        // title: "RULER",
        // description:
        //     "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "images/hpzj.png",
        backgroundColor: Color(0xff9932CC),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    // Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed("/maintab");
    // Navigator.of(context).pushAndRemoveUntil(
    //     new MaterialPageRoute(
    //         builder: (context) => App()),
    //         (route) => route == null);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      // isShowSkipBtn: false,
      // isShowPrevBtn: false,
      colorActiveDot: Colors.white,
      onSkipPress: this.onDonePress,
      onDonePress: this.onDonePress,
      nameSkipBtn: '跳过',
      nameDoneBtn: '确定',
      namePrevBtn: '上一页',
      nameNextBtn: '下一页',
    );
  }
}
