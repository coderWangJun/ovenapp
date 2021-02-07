import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage({Key key, this.vfile}) : super(key: key);

  final String vfile;

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  // VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(widget.vfile);

    // _controller.addListener(() {
    //   setState(() {});
    // });
    // _controller.setLooping(true);
    // _controller.initialize().then((_) => setState(() {}));
    // _controller.play();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

// Future<ClosedCaptionFile> _loadCaptions() async {
//     final String fileContents = await DefaultAssetBundle.of(context)
//         .loadString('assets/bumble_bee_captions.srt');
//     return SubRipCaptionFile(fileContents);
//   }

  @override
  Widget build(BuildContext context) {
    return
        // SingleChildScrollView(
        //   child: Column(
        //     children: <Widget>[
        //       Container(
        //         padding: const EdgeInsets.only(top: 20.0),
        //       ),
        //       const Text('mp4 playing ...'),
        Center(
      child: Container(
          // child: AspectRatio(
          //   aspectRatio: _controller.value.aspectRatio,
          //   child: Stack(
          //     alignment: Alignment.bottomCenter,
          //     children: <Widget>[
          //       VideoPlayer(_controller),
          //       _PlayPauseOverlay(controller: _controller),
          //       VideoProgressIndicator(_controller, allowScrubbing: true),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}

// class _PlayPauseOverlay extends StatelessWidget {
//   const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

//   final VideoPlayerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedSwitcher(
//           duration: Duration(milliseconds: 50),
//           reverseDuration: Duration(milliseconds: 200),
//           child: controller.value.isPlaying
//               ? SizedBox.shrink()
//               : Container(
//                   color: Colors.black26,
//                   child: Center(
//                     child: Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 100.0,
//                     ),
//                   ),
//                 ),
//         ),
//         GestureDetector(
//           onTap: () {
//             controller.value.isPlaying ? controller.pause() : controller.play();
//           },
//         ),
//       ],
//     );
//   }
// }
