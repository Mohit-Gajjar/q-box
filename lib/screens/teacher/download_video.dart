import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../widgets/appbar_actions.dart';



class DownloadVideo extends StatefulWidget {
//   final VideoPlayerController videoPlayerController;
// final bool looping;
// final bool autoplay;
  DownloadVideo({Key? key, }) : super(key: key);

  @override
  State<DownloadVideo> createState() => _DownloadVideoState();
}

class _DownloadVideoState extends State<DownloadVideo> {
   late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  
  @override
  void initState() {
    _controller = VideoPlayerController
    // .asset('assets/video/exaple.mp4');
    .network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
 
    _controller.setLooping(true);
       
    super.initState();
  }
 
  @override
  void dispose() {
    _controller.dispose();
 
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color.fromRGBO(196, 196, 196, 0.75),
        title: Text(
          "Teacher Profile",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[AppBarActions2()],
      ),
      // body: Container(
        // child: Column(
          // children: [
            // FutureBuilder(
            //   future: _initializeVideoPlayerFuture,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return AspectRatio(
            //         aspectRatio: _controller.value.aspectRatio,
            //         child: VideoPlayer(_controller),
            //       );
            //     } else {
            //       return Center(child: CircularProgressIndicator());
            //     }
            //   },
            // ),

         
           
          // ],
        // ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {

      //     setState(() {
      //       // pause
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         // play
      //         _controller.play();
      //       }
      //     });
      //   },
      //   // icon
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),


      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Downlaod Video',
                 style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                 ),
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Chapter Name : Physics',
               style: TextStyle(fontSize: 14, ),
               ),
                ),
              Container(
                height: 260,
                width: 800,
               
                   child:  ListView.builder(
                   itemCount: 4,
                   itemBuilder: (context, index){
                     return  ListTile(
                       title: Text('Video Title details '),
                       leading: Container(
                         height: 90,
                         width: 50,
                         child: Image.asset('assets/images/user.jpg'),
                       ),
                       subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Teacher Name'),
                            Text('40k watching'),
                         ],
                       ),
                      
                       );
                 }
                 )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Chapter Name : Chemistry',
                 style: TextStyle(fontSize: 14, ),
                 ),
              ),
              Container(
                height: 260,
                width: 800,
                // child: FutureBuilder(builder: (context, snapshot){
                //  if(snapshot.hasData){
                   child:  ListView.builder(
                   itemCount: 4,
                   itemBuilder: (context, index){
                     return  ListTile(
                       title: Text('Video Title details '),
                       leading: Container(
                         height: 90,
                         width: 50,
                         child: Image.asset('assets/images/user.jpg'),
                       ),
                       subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Teacher Name'),
                            Text('40k watching'),
                         ],
                       ),
                      
                       );
                 }
                 )
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Chapter Name : Math',
                 style: TextStyle(fontSize: 14, ),
                 ),
               ),
              Container(
                height: 250,
                width: 800,
                // child: FutureBuilder(builder: (context, snapshot){
                //  if(snapshot.hasData){
                   child:  ListView.builder(
                   itemCount: 4,
                   itemBuilder: (context, index){
                     return  ListTile(
                       title: Text('Video Title details '),
                       leading: Container(
                         height: 90,
                         width: 50,
                         child: Image.asset('assets/images/user.jpg'),
                       ),
                       subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Teacher Name'),
                            Text('40k watching'),
                         ],
                       ),
                      
                       );
                 }
                 )
              ),
            ],
          ),
        ),
      ),
    );
  }
}