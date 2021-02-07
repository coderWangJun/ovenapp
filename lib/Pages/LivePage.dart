import 'package:flutter/material.dart';
// import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  // IjkMediaController controller = IjkMediaController();

  @override
  void initState() {
    super.initState();
    this.initPlayer();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  initPlayer() async {
    // await controller.setNetworkDataSource(
    //     'rtmp://live.cfdzkj.com/live/bake',
    //     autoPlay: true);
    print("set data source success");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: IjkPlayer(
        //   mediaController: controller,
        // ),
        );
  }
}
