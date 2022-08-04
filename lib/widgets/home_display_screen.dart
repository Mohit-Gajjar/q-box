import 'package:flutter/material.dart';
import 'package:notes_app/screens/teacher/TeacherProfileScreen.dart';
import 'package:notes_app/screens/video_screen.dart';
import 'package:notes_app/utilities/dimensions.dart';

class HomeDisplayScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String videoLink;
  final String teacherEmail;
  final String batchName;
  final int likes;
  const HomeDisplayScreen(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.likes,
      required this.videoLink,
      required this.teacherEmail,
      required this.batchName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoScreen(
                          title: title,
                          videoLink: videoLink,
                        )));
          },
          child: Container(
            height: Dimensions.height10 * 19,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              SizedBox(
                width: Dimensions.width15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TeacherProfileScreen(
                              collectionPath: "teachers/$teacherEmail",
                              batchName: batchName)));
                },
                child: CircleAvatar(
                  child: Center(child: Text(teacherEmail[0])),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                // width: Dimensions.width10 * 30,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text('${likes} Likes'),
            Text('4 minutes ago'),
            SizedBox(),
          ],
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
