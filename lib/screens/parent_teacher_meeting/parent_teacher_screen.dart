import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utilities/dimensions.dart';
import '../../widgets/appbar_actions.dart';

class ParentTeacherScreen extends StatefulWidget {
  ParentTeacherScreen({Key? key}) : super(key: key);

  @override
  State<ParentTeacherScreen> createState() => _ParentTeacherScreenState();
}

class _ParentTeacherScreenState extends State<ParentTeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromRGBO(196, 196, 196, 0.75),
        title: Text(
          "Parent Teacher Meeting",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[AppBarActions2()],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                'assets/images/meeting.png',
                height: 170,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('PTM').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                        var item = snapshot.data!.docs.length;
                    return (snapshot.hasData)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upcoming ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: Dimensions.height10 * 2,
                              ),
                              for(int i=0; i<item;i++)
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                      color: Colors.black87,
                                      style: BorderStyle.solid,
                                      width: 0.80),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          _completed('Course Name',
                                              '${snapshot.data!.docs[i]['course']}'),
                                          SizedBox(
                                            height: Dimensions.height10 * 1,
                                          ),
                                          _completed('Batch Name   ',
                                              '${snapshot.data!.docs[i]['batch']}'),
                                          SizedBox(
                                            height: Dimensions.height10 * 1,
                                          ),
                                          _completed('Meeting Time',
                                              '${snapshot.data!.docs[i]['time']}'),
                                        ]),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Align(
                                        heightFactor: 4,
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          onPressed: () async{
                                            // final url = 'https://github.com/UMA12345-cmdes/Music-App';
                                           final url = snapshot.data!.docs[i]['meetingLink'];
                                           if(await canLaunch(url)){
                                            await launch(url);
                                           }
                                          },
                                          child: Text('Join'),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10 * 2,
                              ),
                              Container(
                                child: Text(
                                  'Completed',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10 * 2,
                              ),
                              Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                      color: Colors.black87,
                                      style: BorderStyle.solid,
                                      width: 0.80),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          _completed('Course Name',
                                              '${snapshot.data!.docs[0]['course']}'),
                                          SizedBox(
                                            height: Dimensions.height10 * 1,
                                          ),
                                          _completed('Batch Name   ',
                                              '${snapshot.data!.docs[0]['batch']}'),
                                          SizedBox(
                                            height: Dimensions.height10 * 1,
                                          ),
                                          _completed('Meeting Time',
                                              '${snapshot.data!.docs[0]['time']}'),
                                        ]),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Align(
                                        heightFactor: 4,
                                        alignment: Alignment.centerRight,
                                        child: MaterialButton(
                                          color: Colors.red,
                                          onPressed: () {},
                                          child: Text('Expiry'),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10 * 1,
                              ),
                            
                            ],
                          )
                        : Center(
                            child: Text("NOT FOUND"),
                          );
                  }),
            ),
          ],
        ),
      )),
    );
  }

  _completed(String title, String value) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            value,
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
