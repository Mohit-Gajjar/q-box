import 'package:flutter/material.dart';
import 'package:notes_app/screens/analytics/dpp.dart';
import 'package:notes_app/screens/analytics/full_length_test.dart';
import 'package:notes_app/screens/analytics/leader_board.dart';
import 'package:notes_app/screens/analytics/subject_view.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Analytics',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 5,
          shadowColor: Colors.yellowAccent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: const AnalyticsBifercations(txt: 'Subject View'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return const SubjectView();
                    }),
                  ),
                );
              },
            ),
            GestureDetector(
              child: const AnalyticsBifercations(txt: 'Full Length Test'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return const FullLengthTest();
                    }),
                  ),
                );
              },
            ),
            GestureDetector(
              child: const AnalyticsBifercations(txt: 'Ladder Board'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return const LeaderBoard();
                    }),
                  ),
                );
              },
            ),
            GestureDetector(
              child: const AnalyticsBifercations(txt: 'Dpp'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return const Dpp();
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AnalyticsBifercations extends StatelessWidget {
  const AnalyticsBifercations({Key? key, required this.txt}) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: const Color.fromRGBO(246, 246, 246, 0.15),
          shadowColor: Colors.white,
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  txt,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
