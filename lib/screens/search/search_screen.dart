import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/practice_model.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.keyy}) : super(key: key);
  final String keyy;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PracticeModel> plist = [];
  TextEditingController sKey = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.keyy);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search using the #chapter_name or #topic name ',
          ),
          controller: sKey,
          onSubmitted: (value){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>SearchScreen(keyy: value)
                        )));
          },
        ),
      ),
      body: StreamBuilder(
    stream: FirebaseFirestore.instance.collection('practice').where("chapter", isEqualTo: widget.keyy).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
            return Center(
               child: Text("No Search found"),
            );
        }
         return ListView(
          children: snapshot.data!.docs.map((document) {
            print(document['course']);
            return Center(
              child: Column(
                children: [
                  Text(document['course'])
                ],
              ),
            );
          }).toList(),
        );


    }
    ));
  }
}
