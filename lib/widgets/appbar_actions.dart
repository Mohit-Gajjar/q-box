import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/profile.dart';
import 'package:notes_app/screens/search/search_screen.dart';
import 'package:notes_app/utilities/dimensions.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: Dimensions.padding20),
          child: const Icon(
            Icons.cast,
            color: Colors.black,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: Dimensions.padding20),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.black,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: Dimensions.padding20),
          child: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen())),
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: Dimensions.width10),
          child: AppBarProfileIcon(
            profileRadius: Dimensions.width10 * 2,
          ),
        ),
      ],
    );
  }
}

class AppBarProfileIcon extends StatefulWidget {
  final profileRadius;
  AppBarProfileIcon({Key? key, required this.profileRadius}) : super(key: key);

  @override
  State<AppBarProfileIcon> createState() => _AppBarProfileIconState();
}

class _AppBarProfileIconState extends State<AppBarProfileIcon> {
  Future<String?> GetUserProfileName(
      String? documentId, String profileImageName) async {
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(documentId)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     var data = documentSnapshot.data() as Map<String, dynamic>;
    //     print(data);
    //     String filePath = data['profileImageName']! as String;
    //     print(filePath);
    //     return filePath;
    //   }
    // });
    final docData =
        FirebaseFirestore.instance.collection('users').doc(documentId);
    final snapshot = await docData.get();

    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      // UserModel UserCurr = UserModel.fromJson(snapshot.data()!);
      // print('profile url  == ${UserCurr.profileImageName}');
      return data[profileImageName] as String;
    }
    return null;
  }

  // Future<String> getUserImagePath() async {
  //   final user = await FirebaseAuth.instance.currentUser;
  //   final userRef = await FirebaseStorage.instance.ref();
  //   String userEmail = user!.email.toString();
  //   String? fileName = await GetUserProfileName(userEmail, 'profileImageName');
  //   String urlPath = 'users/${userEmail}/UserProfile/${fileName}';
  //   final userProfileUrl = await userRef.child(urlPath).getDownloadURL();
  //   return userProfileUrl;
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Profile.routeName);
      },
      child: Container(
        width: widget.profileRadius * 2,
        height: widget.profileRadius * 2,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(Dimensions.borderRadius5 * 20),
        ),
        child: FutureBuilder(
            // future: getUserImagePath(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return CircleAvatar(
              radius: widget.profileRadius,
              // backgroundImage:
              //  NetworkImage(
              //   snapshot.data!,
              // ),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return Icon(
            Icons.person,
            size: (24 / 40) * widget.profileRadius * 2,
          );
        }),
      ),
    );
  }
}
