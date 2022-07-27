import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/appbar_actions.dart';

import './teacher_details_screen.dart';
import '../../widgets/teacher_profile_card.dart';

class BatcheDetailsScreen extends StatelessWidget {
  BatcheDetailsScreen({Key? key}) : super(key: key);
  static const String routeName = '/batches-details-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;



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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10 * 1.5,
                vertical: Dimensions.height10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var teach in routeArgs['teachers'])
                    TeacherProfileCard(
                        text: teach.toString(),
                        batch: routeArgs['batchName'],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
