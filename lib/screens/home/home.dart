import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/initFunctions.dart';
import 'package:notes_app/screens/batches/live_classes_screen.dart';
import 'package:notes_app/screens/course/select_course.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/category_style.dart';
import 'package:notes_app/widgets/home_display_screen.dart';

class Home extends StatefulWidget {
  static String routeName = 'home';
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List category = [
    'Select Course',
    'LIVE classes',
    'Free classes', // TODO: Free classes screens missing  
    'Did You Know?' // TODO: Did you know missing,  copy paste of the free classes screen
  ];

  List<String> categoryFunction = [
    SelectCourse.routeName,
    LiveClassesScreen.routeName,
    '',
    '',
  ];
  @override
  void initState() {
    getUserEmail();
    initFunctions();
    super.initState();
  }

  initFunctions() {
    setState(() {
      getPurchasedCourse();
      getTrialCourses();
    });
  }

  String userEmail = "";
  void getUserEmail() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    setState(() {
      userEmail = user.email!;
    });
    fetchUserSelectedCouses();
  }

  List selectedCourses = [];

  void fetchUserSelectedCouses() async {
    var docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get();
    if (docRef.exists) {
      Map<String, dynamic> data = docRef.data()!;

      setState(() {
        selectedCourses = data['selectedCourse'] as List;
      });
    }
  }

  getToken()  {
    FirebaseMessaging.instance.getToken().then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .update({"token": value});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Dimensions.height10 * 4,
            margin: EdgeInsets.only(top: Dimensions.height10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryStyleSelectCourse(
                  title: "Select Course",
                  onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Select Catogary'),
                            content: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('cat')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong!');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                return Container(
                                  width: Dimensions.width10 * 10,
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    children: snapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                                      Map<String, dynamic> data = document
                                          .data()! as Map<String, dynamic>;
                                      Map<String, dynamic> courses =
                                          data['courses']
                                              as Map<String, dynamic>;
                                      return CourseTile(
                                        title: document.id.toUpperCase(),
                                        subtitle: courses.keys.toList(),
                                        paymentOptions: courses,
                                        email: userEmail,
                                        selectedCourses: selectedCourses,
                                        courses: courses,
                                      );
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          )),
                ),
                CategoryStyle(
                  title: "Live classes",
                  OnTapRoute: LiveClassesScreen.routeName,
                ),
                CategoryStyle(
                  title: "Free classes",
                  OnTapRoute: '',
                ),
                CategoryStyle(
                  title: "Did You Know?",
                  OnTapRoute: '',
                ),
              ],
            ),
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
                          id: data['id'],
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
    ));
  }
}

// ignore: must_be_immutable
class CategoryStyleSelectCourse extends StatefulWidget {
  final String title;
  void Function() onTap;
  CategoryStyleSelectCourse(
      {Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  State<CategoryStyleSelectCourse> createState() =>
      _CategoryStyleSelectCourseState();
}

class _CategoryStyleSelectCourseState extends State<CategoryStyleSelectCourse> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.borderRadius12 * 2),
          color: Theme.of(context).primaryColor,
        ),
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 1.5),
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  final String title;
  final List subtitle;
  final Map courses;
  final String email;
  final Map<String, dynamic> paymentOptions;
  final List selectedCourses;
  const CourseTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.paymentOptions,
      required this.email,
      required this.selectedCourses,
      required this.courses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Select Course'),
                content: Container(
                  width: Dimensions.height10,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: subtitle.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(subtitle[index]),
                        onTap: () {
                          print(courses[subtitle[index]]);
                          courses[subtitle[index]]['reference']="cat/${title.toLowerCase()}";
                          selectedCourses.add(courses[subtitle[index]]);
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(email)
                              .update({
                            "selectedCourse": selectedCourses,
                          }).then((value) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: "Selected Course: ${subtitle[index]}");
                          });
                        },
                      );
                    },
                  ),
                ),
              );
            }));
  }
}
