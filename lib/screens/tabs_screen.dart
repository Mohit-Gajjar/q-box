import 'package:flutter/material.dart';
import 'package:notes_app/screens/home/home.dart';
import 'package:notes_app/screens/payments/payment_option.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/appbar_actions.dart';

import '../screens/batches/batches_screen.dart';
import 'home/question_bank_screen.dart';
import '../screens/tests/tests_screen.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = 'tabScreen';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}


class _TabsScreenState extends State<TabsScreen> {
  int curIdx = 0;

  final List<Widget> _pages = [
    Home(),
    BatchesScreen(),
    TestsScreen(),
    QuestionsBank(),
    PaymentOption()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 14 * Dimensions.width10,
        leading: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: Dimensions.padding20),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, TabsScreen.routeName);
              },
              child: Text(
                'QrioctyBox',
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          AppBarActions(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: curIdx,
        onDestinationSelected: (int index) {
          setState(() {
            curIdx = index;
          });
        },
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 800),
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          NavigationDestination(
              icon: Icon(
                Icons.explore,
              ),
              label: 'Batches'),
          NavigationDestination(
              icon: Icon(
                Icons.online_prediction_rounded,
              ),
              label: 'tests'),
          NavigationDestination(
              icon: Icon(
                Icons.subscriptions_rounded,
              ),
              label: 'Practice'),
          NavigationDestination(
            icon: Icon(
              Icons.video_library_rounded,
            ),
            label: 'Subscription',
          ),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 70,
      ),
      body: IndexedStack(
        children: [_pages[curIdx]],
      ),
    );
  }
}
