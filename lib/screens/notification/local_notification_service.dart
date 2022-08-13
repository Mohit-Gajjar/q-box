import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notes_app/main.dart';
// import 'package:notes_app/screens/notification/notification_list.dart';

class LocalNotificationService{

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(){
    const InitializationSettings initializationSettings
    = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    _notificationsPlugin.initialize(initializationSettings, 
    onSelectNotification: (String? id) async{
      print('');

      if(id!.isNotEmpty){
        print('router value12345 $id');

        // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        //   NotificationList(),

        // ));
      }
    }
    );
  }

  static void createanddisplaynotification(RemoteMessage message) async{
    try{
        final id = DateTime.now().microsecondsSinceEpoch ~/ 10000;
        const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', 
            'High Importance Notifications',

          importance: Importance.max,
          priority: Priority.high,

          )
        );

        await _notificationsPlugin.show(
          id, 
          message.notification!.title, 
          message.notification!.body, 
           notificationDetails,
           payload: message.data['_id'],
          );
    }
    on Exception catch (e){
      print(e.toString());
    }
  }
}