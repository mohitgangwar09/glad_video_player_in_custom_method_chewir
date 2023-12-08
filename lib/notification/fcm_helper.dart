import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/sharedprefrence.dart';


final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;


Future<void> msyBackgroundMessageHandler(RemoteMessage event) async {
  final message = event.data;
  if (Platform.isIOS) {
    String body = message['body'];
    String title = message['title'];
    showNotificationWithSound(body,title);
  } else {
    String body = message['body'];
    String title = message['title'];
    showNotificationWithSound(body,title);
  }
}

Future showNotificationWithSound(body, message) async {
  print("notification 1");
  if (flutterLocalNotificationsPlugin == null) {
    initNotification();
  }

  // BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
  //   message, htmlFormatBigText: true,
  //   contentTitle: body, htmlFormatContentTitle: true,
  // );

  /*var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Order Channel', 'Order updates',
      importance: Importance.defaultImportance,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
  );*/

  flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
  var platformChannelSpecifics = const NotificationDetails(
      // android: androidPlatformChannelSpecifics
  );

  await flutterLocalNotificationsPlugin?.show(0,
    message,
    body,
    platformChannelSpecifics,
    // payload: pageToken,
  );
}

void initNotification() {

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: const DarwinInitializationSettings(),
  );

  flutterLocalNotificationsPlugin?.initialize(initializationSettings);
}


deleteToken() {
  _firebaseMessaging.deleteToken();
}

class FcmHelper {

  void initFirebase() {
    FirebaseMessaging.onMessage.listen((event) {
      final message = event.data;
      if (Platform.isIOS) {
        String body = message['body'];
        String title = message['title'];
        showNotificationWithSound(body,title);
      } else {

        showNotificationWithSound('body','title');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final message = event.data;
      if (Platform.isIOS) {
        if (message.containsKey('notification')) {
          String body = message['body'];
          String title = message['title'];
          showNotificationWithSound(body,title);
        } else {
          String body = message['body'];
          String title = message['title'];
          showNotificationWithSound(body,title);

        }
      } else {

        "ok".toString().toast();
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
    //Getting the token from FCM
    FirebaseMessaging.instance.getToken().then((value) async{
      print("fcmToken---- $value");
      // value.toString().toast();
      await SharedPrefManager.savePrefString(AppConstants.fcmToken, value.toString());
    });
  }
}
