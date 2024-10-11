import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoSlide extends StatefulWidget {
  final String video;
  final int snappedPageIndex;
  final int currentIndex;
  const VideoSlide({
    super.key,
    required this.video,
    required this.snappedPageIndex,
    required this.currentIndex,
  });

  @override
  State<VideoSlide> createState() => _VideoSlideState();
}

class _VideoSlideState extends State<VideoSlide> {
  late VideoPlayerController videocontroller;
  late Future initalizeVideoplayer;
  bool isplaying = true;

  @override
  void initState() {
    videocontroller = VideoPlayerController.networkUrl(Uri.parse(widget.video));
    initalizeVideoplayer = videocontroller.initialize();
     videocontroller.play();
    videocontroller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    videocontroller.pause();
    videocontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.blue,
      child: FutureBuilder(
          future: initalizeVideoplayer,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return VisibilityDetector(
                key: Key(widget.currentIndex
                    .toString()), // Unique key for each VideoSlide
                onVisibilityChanged: (visibilityInfo) {
                  if (visibilityInfo.visibleFraction == 0) {
                    // Widget is not visible
                    videocontroller.pause();
                    // setState(() {
                    //   isplaying = false;
                    // });
                  } else {
                    // Widget is visible
                    videocontroller.play();
                    // setState(() {
                    //   isplaying = true;
                    // });
                  }
                },
                child: GestureDetector(
                    onTap: () {
                      isplaying
                          ? videocontroller.pause()
                          : videocontroller.play();
                      setState(() {
                        isplaying = !isplaying;
                      });
                    },
                    child: VideoPlayer(videocontroller)),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
