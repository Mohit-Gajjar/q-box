import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utilities/dimensions.dart';

class CommentsScreen extends StatefulWidget {
  CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

  File? imageFile;

  var _sendController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(Dimensions.padding20 / 5),
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 17),
            child: FutureBuilder<QuerySnapshot>(
  future: FirebaseFirestore.instance.collection('videos').get(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return Column(
        children: snapshot.data!.docs.map((doc) {
        List l = doc['comments'] as List;
            return ListTile(
              leading: CircleAvatar(
                                radius: 30,
                                child: Image.asset('assets/images/user.jpg'),),
             title: Text(l[0]['username']),
            subtitle: Text(l[0]['text']),
            );
        }).toList(),
      );
    } else {
      // or your loading widget here
      return Container();
    }
  },
),
          ),

          // Container(
          //       margin: EdgeInsets.all(Dimensions.padding20 / 2),
          //       child: StreamBuilder<QuerySnapshot>(
          //           stream:
          //               FirebaseFirestore.instance.collection('videos').snapshots(),
                    // builder: (BuildContext context,
                    //     AsyncSnapshot<QuerySnapshot> snapshot) {
                      // if (snapshot.hasError) {
                      //   return Text('Something went wrong!');
                      // }
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return Center(child: CircularProgressIndicator());
                      // }
                      // return ListView(
                      //   shrinkWrap: true,
                      //   physics: ClampingScrollPhysics(),
                      //   children:
                      //       snapshot.data!.docs.map((DocumentSnapshot document) {
                      //     Map<String, dynamic> data =
                      //         document.data()! as Map<String, dynamic>;
                      //  Map<String, dynamic> commtData = data['comments'];
                      //     return ListTile(
                            // leading: CircleAvatar(
                            //   radius: 30,
                            //   child: Image.asset('assets/images/user.jpg'),),
                      //        title: Text(commtData['username']),
                      //        subtitle: Text(commtData['text']),
                      //     );

                      //   }).toList(),
                      // );
          //           }),
          //     ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: _sendController,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  label: const Text('You can reply any comment from here'),
                  suffix: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {});
                          _getFromGallery();
                        },
                        icon: Icon(
                          Icons.image_outlined,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _send();
                          });
                        },
                        icon: Icon(
                          Icons.send_sharp,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _send() async {
    DateTime _date = DateTime.now();
   final document = FirebaseFirestore.instance.collection('videos').doc();
    try {
      await FirebaseFirestore.instance
          .collection('videos').doc().set({
             'text': _sendController,
            'createdAt' : _date,
             'userId': document.id,
            'username': FirebaseAuth
                                        .instance.currentUser!.displayName
                                        .toString(),
          })
         
          .then((value) => print("Comments send"))
          .catchError((error) => print("Failed to send: $error"));
      setState(() {});
      _sendController.clear();
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
      }
    }
  }
}
