import 'package:flutter/material.dart';
import 'package:notes_app/screens/course/select_course.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Enjoyed the App?"),
            Text("Enroll your-self and unlock all the benifits."),
            Text("Subscribe to the app."),
            ElevatedButton(
                child: Text("Subscribe"),
                onPressed: () =>
                    Navigator.pushNamed(context, SelectCourse.routeName))
          ],
        ),
      ),
    );
  }
}
