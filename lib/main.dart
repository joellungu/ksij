import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:timezone/data/latest.dart' as tz;
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksij_kinshasa/pages/accueil.dart';
import 'package:ksij_kinshasa/pages/home/evenements/details_evenement.dart';
import 'package:ksij_kinshasa/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ksij_kinshasa/utils/local_notification_service.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';
import 'pages/calendrier/calendrier_controller.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await setupFlutterNotifications();
  LocalNotificationService.initialize();
  LocalNotificationService.display(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    //
    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip =
        new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = AndroidInitializationSettings('logo');
    var IOS = DarwinInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);
    //
    try {
      Map message = json.decode(task);
      print("Native called background task: $task");

      LocalNotificationService.rappel(message);
      print("Native called background task: $task");
      //simpleTask will be emitted here.
    } catch (e) {
      print("erreur:  $e");
    }
    return Future.value(true);
  });
}

//
Future _showNotificationWithDefaultSound(flip) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high);
  var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(
      0,
      'GeeksforGeeks',
      'Your are one step away to connect with GeeksforGeeks',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  //
  var uuid = Uuid();
  //
  channel = AndroidNotificationChannel(
    uuid.v1(), // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // /// Create an Android Notification Channel.
  // ///
  // /// We use this channel in the `AndroidManifest.xml` file to override the
  // /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  //
  isFlutterLocalNotificationsInitialized = true;
}

void _showFlutterNotification(RemoteMessage message) {
  // RemoteNotification? notification = message.notification;
  // AndroidNotification? android = message.notification?.android;
  // if (notification != null && android != null && !kIsWeb) {
  //   flutterLocalNotificationsPlugin.show(
  //     DateTime.now().millisecondsSinceEpoch ~/ 1000,
  //     notification.title,
  //     notification.body,
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         channel.id,
  //         channel.name,
  //         channelDescription: channel.description,
  //         // actions: [
  //         //   AndroidNotificationAction("close", "Close"),
  //         // ],
  //         // TODO add a proper drawable resource to android, for now using
  //         //      one that already exists in example app.
  //         icon: "logo",
  //       ),
  //     ),
  //   );
  // } else {
  //   //
  //   flutterLocalNotificationsPlugin.show(
  //     DateTime.now().millisecondsSinceEpoch ~/ 1000,
  //     message.data['title'],
  //     message.data['body'],
  //     NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           channel.id,
  //           channel.name,
  //           channelDescription: channel.description,
  //           // TODO add a proper drawable resource to android, for now using
  //           //      one that already exists in example app.
  //           icon: 'logo',
  //         ),
  //         iOS: DarwinNotificationDetails()),
  //   );
  // }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  tz.initializeTimeZones();
  //
  await GetStorage.init();
  //
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //
  Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    //isInDebugMode: true
    // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  // Set the background messaging handler early on, as a named top-level function
  // One off task registration

  //
  FirebaseMessaging.onMessage.listen((data) {
    //
    print("Data rec: _____________________________");
    print("Data rec: ${data.category}");
    print("Data rec: _____________________________");
    print("Data rec: ${data.messageId}");
    print("Data rec: _____________________________");
    print("Data rec: ${data.messageType}");
    print("Data rec: _____________________________");
    print("Data rec: ${data.notification!.title}");
    print("Data rec: _____________________________");
    print("Data rec: ${data.notification!.body}");
    print("Data rec: _____________________________");
    print("Data rec: ${data.data}");
    print("Data rec: _____________________________&&&&&&");
    //
    //appController.givePosition();
    //
    LocalNotificationService.display(data);
    //
  });

  //
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //

  //
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    //Get.to();
    Get.to(DetailsEvenement(message.data));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: ((context) {
    //       return DetailsEvenement(message.data);
    //     }),
    //   ),
    // );
  });
  //
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      // DO YOUR THING HERE
      //
      //runApp(const ksij());
      //
      Timer(const Duration(seconds: 1), () {
        //
        Get.to(DetailsEvenement(message.data));
        //
      });

      //router.go("details", extra: message.data);
    }
  });
  //
  FirebaseMessaging.instance.setAutoInitEnabled(false);
  //
  try {
    var box = GetStorage();
    //
    FirebaseMessaging.instance.requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    //
    checkTopic();
    //
    box.write("token", token);
    //
    print("Data rec: $token");
    print("Data rec: ${token!.length}");
    //
    // if (Platform.isIOS) {
    //   String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    //   if (apnsToken != null) {
    //     print("token: $apnsToken");
    //     //await FirebaseMessaging.instance.subscribeToTopic(personID);
    //   } else {
    //     await Future<void>.delayed(
    //       const Duration(
    //         seconds: 3,
    //       ),
    //     );
    //     apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    //     if (apnsToken != null) {
    //       print("token: $apnsToken");
    //       //await _firebaseMessaging.subscribeToTopic(personID);
    //     }
    //   }
    // } else {
    //   //await _firebaseMessaging.subscribeToTopic(personID);
    // }
    //
  } catch (e) {
    print("erreur: $e");
  }

  //
  CalendrierController calendrierController = Get.put(CalendrierController());
  //
  await GetStorage.init();
  //
  if (!kIsWeb) {
    LocalNotificationService.initialize();
    //await setupFlutterNotifications();
  }
  //
  loadNotif();

  //
  runApp(const ksij());
}

class ksij extends StatelessWidget {
  //final Key navigatorKey;
  const ksij({super.key});
  //
  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   routerConfig: router,
    // );
    return GetMaterialApp(
      title: 'Ksij Kinshasa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}

//
loadNotif() async {
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  // AwesomeNotifications().initialize(
  //     // set the icon to null if you want to use the default app icon
  //     'resource://drawable/logo',
  //     [
  //       NotificationChannel(
  //           channelGroupKey: 'basic_channel_group',
  //           channelKey: 'basic_channel',
  //           channelName: 'Basic notifications',
  //           channelDescription: 'Notification channel for basic tests',
  //           defaultColor: Color(0xFF9D50DD),
  //           ledColor: Colors.white)
  //     ],
  //     // Channel groups are only visual and are not required
  //     channelGroups: [
  //       NotificationChannelGroup(
  //         channelGroupKey: 'basic_channel_group',
  //         channelGroupName: 'Basic group',
  //       )
  //     ],
  //     debug: true);
}

//
checkTopic() {
  //
  var box = GetStorage();
  //
  bool evenement = box.read('evenement') ?? true;
  if (evenement) {
    FirebaseMessaging.instance.subscribeToTopic("evenement");
  } else {
    FirebaseMessaging.instance.unsubscribeFromTopic("evenement");
  }
  //

  bool nouvel = box.read('nouvel') ?? true;
  //
  if (nouvel) {
    FirebaseMessaging.instance.subscribeToTopic("nouvel");
  } else {
    FirebaseMessaging.instance.unsubscribeFromTopic("nouvel");
  }
  //
  //
  bool maghrib = box.read('Maghrib') ?? true;
  if (maghrib) {
    FirebaseMessaging.instance.subscribeToTopic("Maghrib");
  } else {
    FirebaseMessaging.instance.unsubscribeFromTopic("Maghrib");
  }
  //

  bool sunset = box.read('Sunset') ?? true;
  //
  if (sunset) {
    FirebaseMessaging.instance.subscribeToTopic("Sunset");
  } else {
    FirebaseMessaging.instance.unsubscribeFromTopic("Sunset");
  }
  //
  //
  bool zuhr = box.read('Zuhr') ?? true;
  if (zuhr) {
    FirebaseMessaging.instance.subscribeToTopic("Zuhr");
  } else {
    FirebaseMessaging.instance.unsubscribeFromTopic("Zuhr");
  }
  //

  bool sunrise = box.read('Sunrise') ?? true;
  //
  if (sunrise) {
    FirebaseMessaging.instance.subscribeToTopic("Sunrise");
  } else {
    FirebaseMessaging.instance.unsubscribeFromTopic("Sunrise");
  }
  //
  //
  bool fajr = box.read('Fajr') ?? true;
  if (fajr) {
    FirebaseMessaging.instance.subscribeToTopic("Fajr");
  } else {
    FirebaseMessaging.instance.unsubscribeFromTopic("Fajr");
  }
  //

  bool imsak = box.read('Imsak') ?? true;
  //
  if (imsak) {
    FirebaseMessaging.instance.subscribeToTopic("Imsak");
  } else {
    FirebaseMessaging.instance.unsubscribeFromTopic("Imsak");
  }
  //
}
