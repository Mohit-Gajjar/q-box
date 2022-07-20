import 'package:flutter/material.dart';
import 'package:notes_app/models/teacherModel.dart';
import 'package:notes_app/models/videoModel.dart';
import 'package:notes_app/screens/batches/completed_classes_screen.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/appbar_actions.dart';
import './live_classes_screen.dart';
import '../../widgets/custom_button_full.dart';

class TeacherDetailsScreen extends StatelessWidget {
  const TeacherDetailsScreen({Key? key}) : super(key: key);
  static const String routeName = '/teacher-details-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // TeacherModel.fromJson(routeArgs['teacher']);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          child: Text(
            routeArgs['batchName'],
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: Dimensions.width10),
            child: AppBarProfileIcon(
              profileRadius: Dimensions.width10 * 2,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width10 * 1.5,
              right: Dimensions.width10 * 1.5,
              top: Dimensions.height10 * 3),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Teacher Name : ${routeArgs['teacher']}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Subject Name : no value in database',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Start Date : " " ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'End Date : " " ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Dimensions.height10 * 6,
                ),
                CustomButtonFull(
                  backColor: Colors.purple,
                  onTaphandler: () {
                    Navigator.of(context)
                        .pushNamed(LiveClassesScreen.routeName);
                  },
                  text: 'Live Classes',
                ),
                SizedBox(
                  height: Dimensions.height10 * 2,
                ),
                CustomButtonFull(
                  backColor: Colors.orange,
                  onTaphandler: () async {
                    List<VideoModel> completedVideoData = [];
                    if (TeacherModel().completedClasses != null) {
                      for (var video in TeacherModel().completedClasses!) {
                        final snapshot = await video.get();
                        if (snapshot.exists) {
                          var data = snapshot.data() as Map<String, dynamic>;
                          completedVideoData.add(VideoModel.fromJson(data));
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('No classes Until Now'),
                      ));
                    }
                    Navigator.pushNamed(
                        context, CompletedClassesScreen.routeName,
                        arguments: {
                          'videosLists': completedVideoData,
                          'teacherName': TeacherModel().name,
                          'subjectName': routeArgs['batchName'],
                        });
                  },
                  text: 'Completed Classes',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
