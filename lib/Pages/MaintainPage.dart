import 'dart:ui';

import 'package:flutter/material.dart';

class MaintainPage extends StatefulWidget {
  @override
  _MaintainPageState createState() => new _MaintainPageState();
}

class _MaintainPageState extends State<MaintainPage> {
  @override
  void initState() {
    super.initState();
    print("@@@ => MaintainPage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();

    print("@@@ MaintainPage.dispose() ...");
  }

// class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("@@@ => MaintainPage.build() ... ");
    return Scaffold(
      appBar: AppBar(
        title: Text('维修列表'),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/maintain_g.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 30.8,
              sigmaY: 30.9,
            ),
            child: Container(
              color: Colors.black54,
              height: 50.0,
              width: 120.0,
              child: Text(
                'data',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
