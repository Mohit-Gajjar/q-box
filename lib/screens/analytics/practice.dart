import 'package:flutter/material.dart';
import 'package:notes_app/screens/tabs_screen.dart';

class DigitalPracticeBook extends StatefulWidget {
  DigitalPracticeBook({Key? key}) : super(key: key);

  @override
  State<DigitalPracticeBook> createState() => _DigitalPracticeBookState();
}

class _DigitalPracticeBookState extends State<DigitalPracticeBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dpb",
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, TabsScreen.routeName);
              },
              icon: Icon(Icons.home)),
        ],
        backgroundColor: Colors.white70,
      ),
      // backgroundColor: Colors.green,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 28,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Text("Name"),
                    Text('Avg Marks'),
                    Text('Rank'),
                  ]),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Indrajit Sikder"),
                  Text('84'),
                  Text('Diamonad \n Icon'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // color: Colors.,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text("Ayan Nandi"),
                    Text('75'),
                    Text('Silver Icon'),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Ayan Mondal"),
                  Text('65'),
                  Text('Bronzee Icon'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Arijit Nandi"),
                  Text('65'),
                  Text('Bronzee Icon'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
