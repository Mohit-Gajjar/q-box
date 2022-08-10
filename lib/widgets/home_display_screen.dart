import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/teacher/TeacherProfileScreen.dart';
import 'package:notes_app/screens/video_screen.dart';
import 'package:notes_app/utilities/dimensions.dart';

import '../models/teacherModel.dart';

class HomeDisplayScreen extends StatefulWidget {
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
  State<HomeDisplayScreen> createState() => _HomeDisplayScreenState();
}

class _HomeDisplayScreenState extends State<HomeDisplayScreen> {
  late TeacherModel teach;
  getTeacher()async{
    await FirebaseFirestore.instance.doc("teachers/${widget.teacherEmail}").get(
    ).then((value){
      setState(() {
        teach=TeacherModel.fromJson(value.data()!);
      });
    });
  }
  @override
  void initState() {
    getTeacher();
    super.initState();
  }
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
                      teacher: teach,
                          title: widget.title,
                          videoLink: widget.videoLink, isUserLiked: false, likes: widget.likes,

                        )));
          },
          child: Container(
            height: Dimensions.height10 * 19,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              image: DecorationImage(
                  image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
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
                              collectionPath: "teachers/${widget.teacherEmail}",
                              batchName: widget.batchName)));
                },
                child: CircleAvatar(
                  child: Center(child: Text(widget.teacherEmail[0])),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                // width: Dimensions.width10 * 30,
                child: Text(
                  widget.title,
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
            Text('${widget.likes} Likes'),
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
