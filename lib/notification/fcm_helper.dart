import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/sharedprefrence.dart';


final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


Future<void> msyBackgroundMessageHandler(RemoteMessage event) async {
  final message = event.notification;
  if (Platform.isIOS) {
    String? body = message!.body;
    String? title = message.title;
    showNotificationWithSound(body,title);
  } else {
    String? body = message!.body;
    String? title = message.title;
    'uuuuu'.toast();
    showNotificationWithSound(body,title);
  }
}

Future showNotificationWithSound(body, message) async {
  print("notification 1");
  // FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  if (flutterLocalNotificationsPlugin == null) {
    initNotification();
    'dddd'.toast();
  }

  BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
    message, htmlFormatBigText: true,
    contentTitle: body, htmlFormatContentTitle: true,
  );

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Order Channel', 'Order updates',
      importance: Importance.defaultImportance,
      priority: Priority.high,
      styleInformation: bigTextStyleInformation,
  );

  flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );

  flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics
  );

  // message.toString().toast();
  print('$flutterLocalNotificationsPlugin');
  await flutterLocalNotificationsPlugin!.show(0,
    message,
    body,
    platformChannelSpecifics,
  );
}

void initNotification() {
  // FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: const DarwinInitializationSettings(),
  );

  // flutterLocalNotificationsPlugin?.initialize(initializationSettings);
  flutterLocalNotificationsPlugin?.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('response');
        response.payload.toString().toast();
      });
}


deleteToken() {
  _firebaseMessaging.deleteToken();
}

class FcmHelper {

  void initFirebase() {

    //Getting the token from FCM
    FirebaseMessaging.instance.getToken().then((value) async{
      print("fcmToken---- $value");
      // value.toString().toast();
      await SharedPrefManager.savePrefString(AppConstants.fcmToken, value.toString());
    });

    FirebaseMessaging.onMessage.listen((event) {
      final message = event.notification;

      if (Platform.isIOS) {
        String? body = message!.body;
        String? title = message.title;
        showNotificationWithSound(body,title);
      } else {
        String? body = message!.body;
        String? title = message.title;
        // "yess".toast();
        showNotificationWithSound(body,title);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final message = event.notification;
      "ok".toString().toast();
      if (Platform.isIOS) {
        String? body = message!.body;
        String? title = message.title;
        showNotificationWithSound(body,title);
      } else {
        String? body = message!.body;
        String? title = message.title;

        showNotificationWithSound(body,title);
      }
    });



    FirebaseMessaging.onBackgroundMessage(
      msyBackgroundMessageHandler,
    );

    //Needed by iOS only
    if (Platform.isIOS) {
      _firebaseMessaging.requestPermission(
        sound: true,
        badge: true,
        alert: true,
      );
    }
  }
}
