
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/notification/local_notification_service.dart';

class NotificationList extends StatefulWidget {
  NotificationList({Key? key}) : super(key: key);

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late  String title; 
  late String body;
  //  late int id;

//  late FirebaseMessaging messaging;
    @override
    void initState() { 
    super.initState();
  
  FirebaseMessaging.instance.getInitialMessage().then((value) => (message){
    print('FirebaseMessaging.instance.getInitialMessage()');
  if(message != null){
    print('new notification');

    // if(message.data['_id'] != null){
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => Notification( id: message.data['_id'],)));
    // }
  }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print(' FirebaseMessaging.onMessageOpenedApp.listen');
    if(message.notification != null){
        print(message.notification!.title);
                print(message.notification!.body);

    }
  });



 FirebaseMessaging.onMessage.listen((message) {
      print("message recieved");
      print(message.notification!.body);
      if(message.notification != null){
        print(message.notification!.title);
                print(message.notification!.body);

        LocalNotificationService.createanddisplaynotification(message);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(message.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      }
    });

    }
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Notification'),
          ),
         body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Card(
                elevation: 2,
                child: ListTile(
                  leading: Text('id'),
                  subtitle: Text('notification title'),
                  title: Text('notification body'),
                )
              ),
            ),
            )), 
        );
   
      }
    }




    // class Notification extends StatelessWidget {
    //       final id;
    //   const Notification({Key? key, this.id}) : super(key: key);
    //   @override
    //   Widget build(BuildContext context) {
    //     return Scaffold(
    //       appBar: AppBar(
    //         title: Text(id),
    //       ),
    //     );
    //   }
    // }
