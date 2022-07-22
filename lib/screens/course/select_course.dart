import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/payments/payment_option.dart';
import 'package:notes_app/utilities/dimensions.dart';

class SelectCourse extends StatefulWidget {
  static const String routeName = '/select-screen';

  const SelectCourse({Key? key}) : super(key: key);

  @override
  State<SelectCourse> createState() => _SelectCourseState();
}

class _SelectCourseState extends State<SelectCourse> {
  @override
  Widget build( context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Course'),
        ),
        body: Container(
          margin: EdgeInsets.all(Dimensions.padding20 / 2),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('cat').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong!');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  Map<String, dynamic> courses =
                      data['courses'] as Map<String, dynamic>;

                  return CourseTile(
                      title: document.id.toUpperCase(),
                      subtitle: courses.keys.toList(), paymentOptions: courses,);
                }).toList(),
              );
            },
          ),
        ));
  }
}

void selectCourse(BuildContext context) {
  return showAboutDialog(
    context: context,
    children: [
      StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('cat').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong!');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  Map<String, dynamic> courses =
                      data['courses'] as Map<String, dynamic>;

                  return CourseTile(
                      title: document.id.toUpperCase(),
                      subtitle: courses.keys.toList(), paymentOptions: courses,);
                }).toList(),
              );
            },
          ),
        
    ]
  );
}

class CourseTile extends StatelessWidget {
  final String title;
  final List subtitle;
  final Map<String, dynamic> paymentOptions;
  const CourseTile({Key? key, required this.title, required this.subtitle, required this.paymentOptions})
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
                          print([paymentOptions[subtitle[index]]['payment']]);
                          // Navigator.popAndPushNamed(
                            
                          //     arguments: {
                          //       'course': subtitle[index],
                          //       'payment': paymentOptions[subtitle[index]]['payment'],
                          //     });
                        },
                      );
                    },
                  ),
                ),
              );
            }));
  }
}
