// ignore_for_file: sized_box_for_whitespace, deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/colors.dart';
import 'package:untitled/ui/product_detailed_screen/widget/full_screen_widget.dart';

import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final String videoPlayer;
  const VideoPlayerWidget({Key? key, required this.videoPlayer, required this.videoPlayerController}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {


  String timePlay = "0:0";
  Timer? timer;
  bool showReplayIcon = false;
  bool showController = false;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => renewTimeText());
    widget.videoPlayerController.addListener(() {
      checkVideo();
    }) ;


  }

  void checkVideo(){
    if (! widget.videoPlayerController.value.isPlaying && widget.videoPlayerController.value.isInitialized &&
        ( widget.videoPlayerController.value.duration == widget.videoPlayerController.value.position)) { //checking the duration and position every time

      showReplayIcon = true;
      setState(() {

      });
    }

  }
  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    timer?.cancel();
    super.dispose();
  }
   showingController(){
     showController = true;
     setState(() {

     });
     Future.delayed(const Duration(seconds: 10), () {

       showController = false;

       setState(() {
         // Here you can write your code for open new view
       });

     });
   }
  renewTimeText()async{
    var time = await  widget.videoPlayerController.position;
    timePlay = "${time?.inMinutes}:${time?.inSeconds}";
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 7.0),
    child: SizedBox(
    child: DecoratedBox(
    decoration: const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(20)),
    boxShadow: [
    BoxShadow(
    offset: Offset(0, 2),
    blurRadius: 6,
    color: Colors.black12,
    ),
    ],
    ),
    child:Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              showingController();
            },
                child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
                  child: AspectRatio(
                  aspectRatio:  widget.videoPlayerController.value.aspectRatio,
                  child: VideoPlayer( widget.videoPlayerController)),
                ),
              ),

          showController?Positioned(
            top: 10,
              left: 10,
              child: InkWell(
                onTap: (){
                  Get.to(()=>FullScreenVideoPlayerWidget(videoPlayer: widget.videoPlayer,));
                },
                child: Container(
                  height: Get.height*0.07,
                  width: Get.width*0.13,
                  decoration:  BoxDecoration(
                    color: Colors.black.withOpacity(0.50),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 6,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )):const SizedBox(),
          showController?Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: Get.width*0.87,
                  decoration:  BoxDecoration(
                    color: Colors.black.withOpacity(0.50),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 6,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      children: [  IconButton(onPressed: (){
                        showingController();
                        widget.videoPlayerController.seekTo(Duration(
                            seconds:  widget.videoPlayerController.value.position.inSeconds - 10));
                      }, icon: const Icon(Icons.fast_forward,color: kBackGroundColor,)),
                        IconButton(onPressed: (){
                          if( widget.videoPlayerController.value.isPlaying){
                            widget.videoPlayerController.pause();
                            showingController();
                            setState(() {

                            });
                          }else{
                            widget.videoPlayerController.play();
                            showingController();
                            setState(() {

                            });
                          }
                        }, icon:  widget.videoPlayerController.value.isPlaying?const Icon(Icons.pause,color: kBackGroundColor,):const Icon(Icons.play_arrow,color: kBackGroundColor,)),
                        IconButton(onPressed: (){
                          showingController();
                          widget.videoPlayerController.seekTo(Duration(
                              seconds:  widget.videoPlayerController.value.position.inSeconds + 10));
                        }, icon: const Icon(Icons.fast_rewind,color: kBackGroundColor,)),

                        Container(
                          width: Get.width*0.1,
                          height: 10,
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(3.0),
                            child: VideoProgressIndicator(

                              widget.videoPlayerController,
                              allowScrubbing: true,
                              colors:  VideoProgressColors(

                                  backgroundColor: kDarkPinkColor.withOpacity(0.5),
                                  bufferedColor:kDarkPinkColor.withOpacity(0.5),
                                  playedColor: kBackGroundColor),
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                          if( widget.videoPlayerController.value.volume == 0.0){
                            widget.videoPlayerController.setVolume(50);
                            showingController();
                            setState(() {

                            });
                          }else{
                            widget.videoPlayerController.setVolume(0);
                            showingController();
                            setState(() {

                            });
                          }
                        }, icon:  widget.videoPlayerController.value.volume == 0.0?const Icon(Icons.volume_mute,color: kBackGroundColor,):const Icon(Icons.volume_up,color: kBackGroundColor,)),
                        Text(
                            "${ widget.videoPlayerController.value.duration.inMinutes}:${ widget.videoPlayerController.value.duration.inSeconds}",
                            style:const TextStyle(color: kBackGroundColor,fontWeight: FontWeight.bold,fontSize: 18)

                        ),
                        const Text(
                            "/",
                            style:TextStyle(color: kBackGroundColor,fontWeight: FontWeight.bold,fontSize: 18)

                        ),
                        Text(
                            timePlay,
                            style:const TextStyle(color: kBackGroundColor,fontWeight: FontWeight.bold,fontSize: 18)

                        ),
                      ],
                    ),
                  ),
                ),
              )):const SizedBox(),
          showReplayIcon?InkWell(
            onTap: (){
              showReplayIcon = false;
              widget.videoPlayerController.seekTo(Duration.zero);
              widget.videoPlayerController.play();
              setState(() {

              });
            },
            child: Center(
              child: AspectRatio(
                aspectRatio:   widget.videoPlayerController.value.aspectRatio,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: Get.height*0.1,
                        width: Get.width*0.2,
                        decoration:  BoxDecoration(
                          color: Colors.black.withOpacity(0.50),
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 6,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                      child: const Icon(
                        Icons.replay,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ):const SizedBox(),
        ],
      ),
    )
    )));
  }
}
