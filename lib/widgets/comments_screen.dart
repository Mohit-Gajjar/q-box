// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../utilities/dimensions.dart';

// class CommentsScreen extends StatefulWidget {
//   CommentsScreen({Key? key}) : super(key: key);

//   @override
//   State<CommentsScreen> createState() => _CommentsScreenState();
// }

// class _CommentsScreenState extends State<CommentsScreen> {
// List element = [];

//   @override
//   void initState() {
// displayCommments();
//     // TODO: implement initState
//     super.initState();
//   }

//   void displayCommments() async {
//     FirebaseFirestore.instance
//         .collection('videos')
//         .doc(widget.id)
//         .get()
//         .then((value) {
//       Map<String, dynamic>? data = value.data();
//       setState(() {
//         element = data!['comments'] as List;
//       });
//     });
//   }
//   File? imageFile;

//   var _sendController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//          Container(
//             margin: EdgeInsets.all(Dimensions.padding20 / 5),
//             child: ListView.builder(
//               shrinkWrap: true,
//                     itemCount: element.length,
//               itemBuilder: (context, index){
//                return ListTile(
//                 leading: CircleAvatar(
//                                 backgroundColor: Colors.blue,
//                                 backgroundImage:
//                                     Image.asset('assets/images/user.jpg').image,
//                               ), 
//                title: Text(element[index]['username']),
//                subtitle: Text(element[index]['text']),
//                 );

//             }),
//                              ),

//           // Container(
//           //       margin: EdgeInsets.all(Dimensions.padding20 / 2),
//           //       child: StreamBuilder<QuerySnapshot>(
//           //           stream:
//           //               FirebaseFirestore.instance.collection('videos').snapshots(),
//                     // builder: (BuildContext context,
//                     //     AsyncSnapshot<QuerySnapshot> snapshot) {
//                       // if (snapshot.hasError) {
//                       //   return Text('Something went wrong!');
//                       // }
//                       // if (snapshot.connectionState == ConnectionState.waiting) {
//                       //   return Center(child: CircularProgressIndicator());
//                       // }
//                       // return ListView(
//                       //   shrinkWrap: true,
//                       //   physics: ClampingScrollPhysics(),
//                       //   children:
//                       //       snapshot.data!.docs.map((DocumentSnapshot document) {
//                       //     Map<String, dynamic> data =
//                       //         document.data()! as Map<String, dynamic>;
//                       //  Map<String, dynamic> commtData = data['comments'];
//                       //     return ListTile(
//                             // leading: CircleAvatar(
//                             //   radius: 30,
//                             //   child: Image.asset('assets/images/user.jpg'),),
//                       //        title: Text(commtData['username']),
//                       //        subtitle: Text(commtData['text']),
//                       //     );

//                       //   }).toList(),
//                       // );
//           //           }),
//           //     ),

//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: TextFormField(
//                 controller: _sendController,
//                 decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     label: const Text('You can reply any comment from here'),
//                     suffix: Wrap(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             setState(() {});
//                             _getFromGallery();
//                           },
//                           icon: Icon(
//                             Icons.image_outlined,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 15,
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _send();
//                             });
//                             _sendController.clear();
//                           },
//                           icon: Icon(
//                             Icons.send_sharp,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     )),
//               ),
//             ),
//             // IconButton(onPressed: (){

//             // }, icon: Icon(Icons.send_sharp, color: Colors.blue,))
//             //  Row(
//             //             mainAxisAlignment: MainAxisAlignment.end,
//             //             crossAxisAlignment: CrossAxisAlignment.end,
//             //             children:  [ IconButton(onPressed: (){
//             //               setState(() {

//             //               });
//             //               _getFromGallery();

//             //             }, icon: Icon(Icons.image_outlined, color: Colors.blue,),),

//             //               const SizedBox(width: 15,),
//             //              IconButton(onPressed: (){}, icon: Icon(Icons.send_sharp, color: Colors.blue,),),
//             //             ],
//             //           )
//           ],
//         ),
      
//     );
//   }

//   _getFromGallery() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   void _send() async {
//     DateTime _date = DateTime.now();
//     var collection = FirebaseFirestore.instance.collection('videos');
//     try {
//       List<Map<String, dynamic>> updatedList = [
//         {
//           'text': _sendController.text,
//           'createdAt': _date.toString(),
//           'username': FirebaseAuth.instance.currentUser!.email,
//           'userId': collection.id
//         }
//       ];
      
//       Map<String, dynamic> updatedData = {
//         'comments': FieldValue.arrayUnion(updatedList),
//       };

//        collection.doc(widget.id)
//           .update(updatedData)
//           .then((value) => print("Comments send"))
//           .catchError((error) => print("Failed to send: $error"));
//       setState(() {});
//       _sendController.clear();
//     } on FirebaseAuthException catch (error) {
//       switch (error.code) {
//       }
//     }
//   }
// }
