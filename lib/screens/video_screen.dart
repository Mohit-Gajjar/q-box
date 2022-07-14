import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../utilities/dimensions.dart';

class VideoScreen extends StatefulWidget {
  static const String routeName = '/videoScreen';
  final String title;
  final String videoLink;
  VideoScreen({Key? key, required this.title, required this.videoLink})
      : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late FlickManager flickManager;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(widget.videoLink)
          ..addListener(() {
            print("added");
            // setState(() {});
          })
          ..initialize().then((value) {
            print('initialized listener');
            setState(() {});
          }).catchError((error) {
            print('Unexpected error1: $error');
          }));
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  @override
  void dispose() {
    flickManager.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: Dimensions.height10 * 25,
            padding: EdgeInsets.all(Dimensions.padding20 / 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.borderRadius5),
              child: FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControls: FlickVideoWithControls(
                  controls: FlickPortraitControls(),
                ),
                flickVideoWithControlsFullscreen: FlickVideoWithControls(
                  controls: FlickLandscapeControls(),
                ),
              ),
            ),
          ),
          // Center(
          //   child: _controller.value.isInitialized
          //       ? AspectRatio(
          //           aspectRatio: _controller.value.aspectRatio,
          //           child: VideoPlayer(_controller),
          //         )
          //       : Container(),
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
