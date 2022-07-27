import 'package:flutter/material.dart';
import 'package:notes_app/screens/tabs_screen.dart';

class LadderBoard extends StatefulWidget {
  LadderBoard({Key? key}) : super(key: key);

  @override
  State<LadderBoard> createState() => _LadderBoardState();
}

class _LadderBoardState extends State<LadderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ladder Board",
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
                  children: <Widget>[
                    Text("Name"),
                    Text('Avg Marks'),
                    Text('Rank'),
                  ]),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Indrajit Sikder"),
                  Text('95%'),
                  Text('Diamonad \nIcon'),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                // color: Colors.,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Ayan Nandi"),
                    Text('95%'),
                    Text('Silver Icon'),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Ayan Mondal"),
                  Text('75'),
                  Text('Bronzee Icon'),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Arijit Nandi"),
                  Text('68'),
                  Text('Bronzee Icon'),
                ],
              ),
              // SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
