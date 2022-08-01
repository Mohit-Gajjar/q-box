import 'package:flutter/material.dart';
import 'package:notes_app/models/videoModel.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/home_display_screen.dart';

class CompletedClassesScreen extends StatefulWidget {
  static String routeName = '/completedClassesScreen';
  const CompletedClassesScreen({Key? key}) : super(key: key);

  @override
  State<CompletedClassesScreen> createState() => _CompletedClassesScreenState();
}

class _CompletedClassesScreenState extends State<CompletedClassesScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    List videos = routeArgs['videosLists'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${routeArgs['teacherName']} - ${routeArgs['subjectName']}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: videos.length == 0
            ? Center(
                child: Text(
                  'No Videos At!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              )
            : Container(
                margin: EdgeInsets.all(Dimensions.padding20),
                child: Column(
                  children: [
                    for (VideoModel singleVideo in videos)
                      HomeDisplayScreen(
                          videoLink: singleVideo.videoLink!,
                          title: singleVideo.title!,
                          imageUrl: singleVideo.imageUrl!,
                          likes: singleVideo.likes!, batchName: '', teacherEmail: '',),
                  ],
                ),
              ),
      ),
    );
  }
}
