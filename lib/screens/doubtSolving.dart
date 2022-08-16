// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/dimensions.dart';
import '../widgets/appbar_actions.dart';

class DoubtSolvingScreen extends StatefulWidget {
  const DoubtSolvingScreen({Key? key}) : super(key: key);

  @override
  State<DoubtSolvingScreen> createState() => _DoubtSolvingScreenState();
}

class _DoubtSolvingScreenState extends State<DoubtSolvingScreen> {
  //launch url
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: implement dynamic links for each course related doubt solving links
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          "Doubt Solving",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[AppBarActions2()],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              title: Text("Doubt Solving Only For JEE ",
              style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w700),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 65,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(
                      color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                ),
                      
                        child: TextButton(
                            onPressed: () {
                              _launchURL("https://t.me/mathematicsqrioctybox");
                            },
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/images/doubt_solving.png', height: 70,),
                              Text('Mathematics Group', 
                                style: TextStyle(color: Colors.black87, fontSize: 16),
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.black12,)
                            ],
                          )),
                    ),
                     SizedBox(
                                  height: Dimensions.height10 * 1,
                                ),
                    Container(
                       height: 65,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(
                      color: Colors.black38, style: BorderStyle.solid, width: 0.80),
                ),
                      child: TextButton(
                          onPressed: () {
                            _launchURL("https://t.me/physicsqrioctybox");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/images/doubt_solving.png', height: 70,),
                              Text('Physics Group', 
                                style: TextStyle(color: Colors.black87, fontSize: 16),
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.black12,)
                            ],
                          )),
                    ),
                     SizedBox(
                                  height: Dimensions.height10 * 1,
                                ),
                    Container(
                       height: 65,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(
                      color: Colors.black38, style: BorderStyle.solid, width: 0.80),
                ),
                      child: TextButton(
                          onPressed: () {
                            _launchURL("https://t.me/chemistryqrioctybox");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Image.asset('assets/images/doubt_solving.png', height: 70,),
                              Text('Chemistry Group', 
                                style: TextStyle(color: Colors.black87, fontSize: 16),
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.black12,)
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListTile(
              title: Text("Doubt Solving Only For NEET ",
              style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w600),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric( vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                         height: 65,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(
                        color: Colors.black38, style: BorderStyle.solid, width: 0.80),
                  ),
                      child: TextButton(
                          onPressed: () {
                            _launchURL("https://t.me/biologyqrioctybox");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Image.asset('assets/images/doubt_solving.png', height: 70,),
                              Text('Biology Group', 
                                style: TextStyle(color: Colors.black87, fontSize: 16),
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.black12,)
                            ],
                          )),
                    ),
                    SizedBox(
                                  height: Dimensions.height10 * 1,
                                ),
                    Container(
                         height: 65,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(
                        color: Colors.black38, style: BorderStyle.solid, width: 0.80),
                  ),
                      child: TextButton(
                          onPressed: () {
                            _launchURL("https://t.me/physicsqrioctybox");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Image.asset('assets/images/doubt_solving.png', height: 70,),
                              Text('Physics Group', 
                                style: TextStyle(color: Colors.black87, fontSize: 16),
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.black12,)
                            ],
                          )),
                    ),
                     SizedBox(
                                  height: Dimensions.height10 * 1,
                                ),
                    Container(
                         height: 65,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(
                        color: Colors.black38, style: BorderStyle.solid, width: 0.80),
                  ),
                      child: TextButton(
                          onPressed: () {
                            _launchURL("https://t.me/chemistryqrioctybox");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/images/doubt_solving.png', height: 70,),
                              Text('Chemistry Group', 
                                style: TextStyle(color: Colors.black87, fontSize: 16),
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.black12,)
                            ],
                          )),
                    ),
                     SizedBox(
                                  height: Dimensions.height10 * 1,
                                ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
