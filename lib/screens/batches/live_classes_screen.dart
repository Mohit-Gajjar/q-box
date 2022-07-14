import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/appbar_actions.dart';

import './live_video_play_screen.dart';

class LiveClassesScreen extends StatelessWidget {
  const LiveClassesScreen({Key? key}) : super(key: key);
  static const String routeName = '/live-classes-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 14 * Dimensions.width10,
        leading: Padding(
          padding: EdgeInsets.only(left: Dimensions.width10),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Live Classes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          AppBarActions(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: Dimensions.padding20 * (3 / 4),
            right: Dimensions.padding20 * (3 / 4),
            top: Dimensions.padding20,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(LiveVideoPlayScreen.routeName);
                      },
                      borderRadius: BorderRadius.circular(
                          Dimensions.borderRadius12 * (2 / 3)),
                      child: Container(
                        height: Dimensions.height10 * 13,
                        margin:
                            EdgeInsets.symmetric(vertical: Dimensions.height10),
                        padding: EdgeInsets.all(Dimensions.padding20 / 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadius5 * 3),
                        ),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: Dimensions.height10 * 10,
                              child: Image.asset(
                                'assets/images/thumbnail.png',
                              ),
                            ),
                            const Align(
                              child:
                                  Text('Chapter name, Start time , End time'),
                              alignment: Alignment.bottomCenter,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
