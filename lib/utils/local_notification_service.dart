import 'dart:convert';
import 'dart:math' as math;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/pages/home/evenements/details_evenement.dart';
import 'package:timezone/src/date_time.dart';
import 'package:timezone/src/location.dart';
import 'package:uuid/uuid.dart';

class LocalNotificationService {
// Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //
  static void initialize() {
    // Initialization setting for android
    InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
      android: AndroidInitializationSettings("@drawable/logo"),
      iOS: DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
          //print(
          //"la fonction = onDidReceiveLocalNotification : $id , $title, $body, $payload ");
        },
      ),
    );
    //
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        //
        print('::::::::');
        print('notification(${notificationResponse.id}) action tapped: '
            '${notificationResponse.actionId} with'
            ' payload: ${notificationResponse.payload}');
        print(
            '-------(${notificationResponse.notificationResponseType.name}) action: '
            '${notificationResponse.notificationResponseType.index} ');
        //
        Map data = json.decode(notificationResponse.payload!);
        //
        if (data['topic'] == "evenement" || data['topic'] == "nouvel") {
          //
          Get.to(
            DetailsEvenement(
              data,
            ),
          );
        }

        //
      },
      //onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static rappel(Map message) async {
    //
    var uuid = Uuid();
    //
    var channel = AndroidNotificationChannel(
      uuid.v1(), // id
      'High Importance Notifications ${uuid.v1()}', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    try {
      print("rappel ok!");
      /**
       * AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // actions: [
          //   AndroidNotificationAction("close", "Close"),
          // ],
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: "logo",
        ),
      
       */
      //print(message.notification!.android!.sound);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            //groupKey: "gfg",
            //color: Colors.green,
            importance: Importance.max,
            // sound: RawResourceAndroidNotificationSound(
            //     message.notification!.android!.sound ?? "gfg"),
            // different sound for
            // different notification
            //playSound: true,
            priority: Priority.high),
      );
      //RemoteNotification? notification = message.notification;
      //AndroidNotification? android = message.notification?.android;
      //notification != null && android != null && !kIsWeb
      if (true) {
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          message['titre'],
          message['data'],
          //RepeatInterval.everyMinute,
          //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)),
          //TZDateTime.from(DateTime(2024, 1, 25, 22, 23), tz.local),
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.high,
              priority: Priority.high,
              // TODO add a proper drawable resource to android, for now using
              //    one that already exists in example app.
              icon: "logo",
            ),
          ),
          //payload: json.encode(message.data),
        );
      }
    } catch (e) {
      //
      print("erreur: $e");
    }
  }

  static Future<void> display(RemoteMessage message) async {
    // To display the notification in device
    //
    var uuid = Uuid();
    //
    var channel = AndroidNotificationChannel(
      uuid.v1(), // id
      'High Importance Notifications ${uuid.v1()}', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    try {
      /**
       * AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // actions: [
          //   AndroidNotificationAction("close", "Close"),
          // ],
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: "logo",
        ),
      
       */
      print(message.notification!.android!.sound);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            //groupKey: "gfg",
            //color: Colors.green,
            importance: Importance.max,
            // sound: RawResourceAndroidNotificationSound(
            //     message.notification!.android!.sound ?? "gfg"),
            // different sound for
            // different notification
            //playSound: true,
            priority: Priority.high),
      );
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      //
      if (notification != null && android != null && !kIsWeb) {
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              actions: [
                AndroidNotificationAction(
                  "view",
                  "View",
                  showsUserInterface: true,
                ),
                // AndroidNotificationAction(
                //   "close",
                //   "Close",
                //   cancelNotification: true,
                //   showsUserInterface: false,
                // ),
              ],
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "logo",
            ),
          ),
          payload: json.encode(message.data),
        );
      } else {
        //
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          message.data['title'],
          message.data['body'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              actions: [
                AndroidNotificationAction(
                  "view",
                  "View",
                  showsUserInterface: true,
                ),
                // AndroidNotificationAction(
                //   "close",
                //   "Close",
                //   cancelNotification: true,
                //   showsUserInterface: false,
                // ),
              ],
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "logo",
            ),
          ),
          payload: json.encode(message.data),
        );
      }

      //_____________________________________
      // await _notificationsPlugin.show(
      //   id,
      //   message.data['title'],
      //   message.data['body'],
      //   NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channelDescription: channel.description,
      //           // actions: [
      //           //   AndroidNotificationAction("close", "Close"),
      //           // ],
      //           // TODO add a proper drawable resource to android, for now using
      //           //      one that already exists in example app.
      //           icon: "logo",
      //         ),
      //       ),
      //   //notificationDetails,
      //   payload: message.data['route'],
      // );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //
  //
  static Future zonedScheduleNotification(
      String note, DateTime date, occ) async {
    // IMPORTANT!!
    //tz.initializeTimeZones(); --> call this before using tz.local (ideally put it in your init state)

    int id = math.Random().nextInt(10000);
    print(date.toString());
    print(tz.TZDateTime.parse(tz.local, date.toString()).toString());
    try {
      await _notificationsPlugin.zonedSchedule(
        id,
        occ,
        note,
        tz.TZDateTime.parse(tz.local, date.toString()),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            channelDescription: 'your channel description',
            largeIcon: DrawableResourceAndroidBitmap("logo"),
            icon: "logo",
            //playSound: true,
            //sound: RawResourceAndroidNotificationSound('bell_sound'),
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      return id;
    } catch (e) {
      print("Error at zonedScheduleNotification----------------------------$e");
      if (e ==
          "Invalid argument (scheduledDate): Must be a date in the future: Instance of 'TZDateTime'") {
        Get.snackbar("Pas cool", "Select future date");
      }
      return -1;
    }
  }
}
