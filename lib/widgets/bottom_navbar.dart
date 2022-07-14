import 'package:flutter/material.dart';

import '../../screens/batches/batches_screen.dart';
import '../../screens/tests/tests_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key, required this.currentIndex})
      : super(key: key);

  final int currentIndex;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (int index) {
        switch (index) {
          case 0:
            break;
          case 1:
            Navigator.of(context).pushNamed(BatchesScreen.routeName);
            break;
          case 2:
            Navigator.of(context).pushNamed(TestsScreen.routeName);
            break;
          default:
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              color: Colors.black,
            ),
            label: 'Batches'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.online_prediction_rounded,
              color: Colors.black,
            ),
            label: 'tests'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.subscriptions_rounded,
              color: Colors.black,
            ),
            label: 'Practice'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.video_library_rounded,
            color: Colors.black,
          ),
          label: 'Subscriptions',
        ),
      ],
      enableFeedback: true,
      //selectedItemColor: Colors.black,
      fixedColor: Colors.black,
    );
  }
}
