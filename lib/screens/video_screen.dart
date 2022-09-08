import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:notes_app/initFunctions.dart';
import 'package:notes_app/screens/teacher/TeacherProfileScreen.dart';
import 'package:notes_app/widgets/comments_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import '../models/teacherModel.dart';
import '../utilities/dimensions.dart';
import '../widgets/home_display_screen.dart';

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
  bool pressedComment = false;
  late FlickManager flickManager;
  late VideoPlayerController _controller;
  User? user = FirebaseAuth.instance.currentUser!;
  bool liked=false;
   int? like;
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
  //  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();
    //  futureFiles = FirebaseStorage.instance.ref('/freeVideos/videos').listAll();
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
      body: SingleChildScrollView(
        child: Padding(
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
                        IconButton(
                          onPressed: () async{
                          //    final User user = await FirebaseAuth.instance.currentUser!;
                          //    await FirebaseFirestore.instance
                          // .collection("videos")
                          // .doc().update({'likes': (liked) ? like!-1 :like!+1})
                        //   .set({
                        // "likes": 
                        //     (liked) ? like!-1 :like!+1 });
                        
                      // }, SetOptions(merge: true)).then((value) {
                      //   Fluttertoast.showToast(msg: (liked)?"liked":"liked!");
                       
                      // });
                          setState(() {
                            liked=!liked;
                            like=(liked) ? like!+1 :like!-1;
                          });
                        }, icon: Icon(Icons.thumb_up_sharp, color: (liked)  ? Colors.amber:Colors.black,)),
                        Text(like.toString())
                      ],
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentsScreen()
                                )); 

                      }, 
                      icon: Icon(Icons.comment)),
                    SizedBox(width: 70,),
                    IconButton(
                      onPressed: (){
                             setState(() {
                      });
                                            // downloadFile();
      
                      }, 
                      icon: Icon(Icons.download_rounded)),
                  ],
                ),
              ),
              Card(
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherProfileScreen(
                                collectionPath: "teachers/${widget.teacher.email}",
                                batchName: widget.title
                                )
                                ));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: (widget.teacher.profilePicUrl==null)?Text(widget.teacher.name![0]):Image.network(widget.teacher.profilePicUrl!),
                          ),
                          SizedBox(width: 10,),
                          Text(widget.teacher.name!, style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold),)
                        ],
                      ),
                    ),
                    TextButton(onPressed: ()async {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(user?.email)
                          .set({
                        "followedTeachers":(followed)?
                        FieldValue.arrayRemove(
                            [widget.teacher.email]): 
                            FieldValue.arrayUnion(
                            [widget.teacher.email]),
      
                      }, SetOptions(merge: true)).then((value) {
                        Fluttertoast.showToast(msg: (followed)?"Unfollowed":"Followed!");
                        setState(() {
                          followed=!followed;
                        });
                      });
                    }, 
                    child: Text((followed)?"Follow":"Followed"))
                  ],
                )
      
              ),
      
    
               Container(
              margin: EdgeInsets.all(Dimensions.padding20 / 2),
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('videos').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong!');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
      
                          },
                          child: HomeDisplayScreen(
                            videoLink: data['videoLink'],
                            imageUrl: data['imageUrl'],
                            title: data['title'],
                            likes: data['likes'],
                            teacherEmail: data['uploadedTeacherEmail'] ,
                            batchName: data['batchName'],
                            uploadDate: data['uploadDate'],
                          ),
                        );
                      }).toList(),
                    );
                  }),
            ),
      
            ],
          ),
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


//    Future downloadFile(Reference ref) async{
//     final url = await ref.getDownloadURL();
    
//     final tempDir = await getTemporaryDirectory();
//     final path = '${tempDir.path}/${ref.name}';
//      await Dio().download(url, path);

//      if(url.contains('.mp4')){
//       await GallerySaver.saveVideo(path, toDcim: true);

//      }
//      else if(url.contains('.png')){
//       await GallerySaver.saveImage(path, toDcim: true);
//      }
//       else if(url.contains('.jpg')){
//       await GallerySaver.saveImage(path, toDcim: true);
//      }
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('download ${ref.name}')));
//   }
}
