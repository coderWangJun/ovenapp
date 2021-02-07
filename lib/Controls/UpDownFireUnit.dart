// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/Models/UpDownFireModel.dart';

class UpDownFireUnit extends StatefulWidget {
  UpDownFireUnit({Key key, this.upDownFireModel}) : super(key: key);
  // final power;
  // final temp;
  // final isOpen;
  final UpDownFireModel upDownFireModel;
  @override
  _UpDownFireUnitState createState() => _UpDownFireUnitState();
}

class _UpDownFireUnitState extends State<UpDownFireUnit> {
  double _power;
  double _temp;
  int _isOpen;
  int _index;
  @override
  void initState() {
    print("@@@ => UpDownFireUnit.initState() ... ");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    print("@@@ UpDownFireUnit.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    _index = widget.upDownFireModel.index;
    _power = widget.upDownFireModel.power;
    _temp = widget.upDownFireModel.temp;
    _isOpen = widget.upDownFireModel.isOpen;
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      appBar: null,
      body:Container(
        // height: 120.0,
        child:
       Column(
        children: <Widget>[
          Text("上火参数设置："),
          Container(
            height: 60.0,
            alignment: Alignment.center,
            // color: Colors.orangeAccent, Cupertino
            child: Switch(
                value: _isOpen == 1,
                onChanged: (v) {
                  setState(() {
                    _isOpen = v ? 1 : 0;
                  });
                }),
          ),
          Container(
            height: 60.0,
            alignment: Alignment.center,
            // color: Colors.orangeAccent,
            child: Slider(
                label: '$_power',
                value: _power,
                // divisions: 10,
                max: 10.0,
                min: 0.0,
                onChanged: (v) {
                  print("_power : " + _power.toString());
                  setState(() {
                    _power = v;
                  });
                }),
          ),
          Container(
            height: 60.0,
            alignment: Alignment.center,
            // color: Colors.orangeAccent,
            child: Slider(
                label: '$_temp',
                value: _temp,
                // divisions: 999,
                max: 999.0,
                min: 0.0,
                onChanged: (v) {
                  print("_temp : " + _temp.toString());
                  setState(() {
                    _temp = v;
                  });
                }),
          ),
        ],
      ),
    ),);
  }
}
