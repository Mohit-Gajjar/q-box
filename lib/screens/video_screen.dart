import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/initFunctions.dart';
import 'package:video_player/video_player.dart';

import '../models/teacherModel.dart';
import '../utilities/dimensions.dart';
import '../widgets/home_display_screen.dart';
import 'batches/teacher_details_screen.dart';

class VideoScreen extends StatefulWidget {
  static const String routeName = '/videoScreen';
  final String title;
  final String videoLink;
  final int likes;
  final bool isUserLiked;
  final TeacherModel teacher;
  
  VideoScreen({Key? key, required this.title, required this.videoLink, required this.likes, required this.isUserLiked, required this.teacher})
      : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late FlickManager flickManager;
  late VideoPlayerController _controller;
  User? user = FirebaseAuth.instance.currentUser!;
  bool liked=false;
  late int like;
  bool followed=false;

  isTeacherFollowed(){
    for(var x in gFollowedTeachers){
      if(x['email']==widget.teacher.email){
        setState(() {
          followed=true;
        });
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    isTeacherFollowed();
    liked = widget.isUserLiked;
    like = widget.likes;
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          liked=!liked;
                          like=(liked)?like+1:like-1;
                        });
                      }, icon: Icon(Icons.thumb_up_sharp, color: (liked)?Colors.amber:Colors.black,)),
                      Text(like.toString())
                    ],
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.comment)),
                  SizedBox(width: 70,),
                  IconButton(onPressed: (){}, icon: Icon(Icons.download_rounded)),
                ],
              ),
            ),
            Card(
              child : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: (widget.teacher.profilePicUrl==null)?Text(widget.teacher.name![0]):Image.network(widget.teacher.profilePicUrl!),
                      ),
                      SizedBox(width: 10,),
                      Text(widget.teacher.name!, style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold),)
                    ],
                  ),
                  TextButton(onPressed: ()async {
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(user?.email)
                        .set({
                      "followedTeachers":(followed)?FieldValue.arrayRemove(
                          [widget.teacher.email]): FieldValue.arrayUnion(
                          [widget.teacher.email])
                    }, SetOptions(merge: true)).then((value) {
                      Fluttertoast.showToast(msg: (followed)?"Unfollowed":"Followed!");
                      setState(() {
                        followed=!followed;
                      });
                    });
                  }, child: Text((followed)?"Followed":"Follow"))
                ],
              )

            ),
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.teacher.completedClasses?.length,
                itemBuilder: (context,index)=>HomeDisplayScreen(
                videoLink: widget.teacher.completedClasses![index]['videoLink'],
                imageUrl: widget.teacher.completedClasses![index]['imageUrl'],
                title: widget.teacher.completedClasses![index]['title'],
                likes: int.parse(widget.teacher.completedClasses![index]['likes']),
                teacherEmail: widget.teacher.email! ,
                batchName: widget.teacher.completedClasses![index]['batchName'],
              ),),
            )
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
