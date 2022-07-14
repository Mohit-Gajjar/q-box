import 'package:flutter/material.dart';
import 'package:notes_app/screens/tabs_screen.dart';

import '../utilities/dimensions.dart';

class Explore extends StatelessWidget {
  static String routeName = 'explore';
  const Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(Dimensions.padding20),
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/Group.png'),
            const Text(
              'Explore The App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Least sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, TabsScreen.routeName);
              },
              child: Padding(
                padding: EdgeInsets.all(Dimensions.padding20 / 2),
                child: Container(
                  width: double.infinity,
                  height: 51,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius5),
                  ),
                  child: const Center(
                    child: Text(
                      "Lets Start",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              'Tutorials?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )),
      ),
    );
  }
}
