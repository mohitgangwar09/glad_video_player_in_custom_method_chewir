import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/notification/fcm_navigation.dart';
import 'package:glad/screen/auth_screen/splash_screen.dart';
import 'package:glad/screen/farmer_screen/common/active_project_detail.dart';
import 'package:glad/screen/farmer_screen/common/suggested_project_details.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/sharedprefrence.dart';
import 'package:shared_preferences/shared_preferences.dart';


final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
late FirebaseApp _firebaseApp;

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
  print('OnTap BG');
  if(response.payload != '') {
    FcmNavigation.handleBackgroundStateNavigation(jsonDecode(response.payload!));
  }
}

Future<void> msyBackgroundMessageHandler(RemoteMessage? message) async {
  print('Background Handler Notification');
  if (message != null) {
    if(message.data.isNotEmpty) {
      print(message.data);
      print("------------------");
    }
    FcmHelper.showNotification(message);
  }
}

class FcmHelper {

  void initFirebase() async {

    _firebaseApp = await Firebase.initializeApp();
    // _firebaseAnalytics = FirebaseAnalytics.instanceFor(app: _firebaseApp);

    //Getting the token from FCM
    _firebaseMessaging.getToken().then((value) async{
      print("fcmToken---- $value");
      await SharedPrefManager.savePrefString(AppConstants.fcmToken, value.toString());
    });

    await initLocalNotifications();

    FirebaseMessaging.onBackgroundMessage(
      msyBackgroundMessageHandler,
    );

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) async{
      if (message != null && message.data.isNotEmpty) {
        print('Kill State Notification');
        print(message.data);
        print("------------------");

        await SharedPrefManager.savePrefString('payload', jsonEncode(message.data));

        const SplashScreen().navigate(isRemove: true);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      print('Foreground State Notification');
      if (message != null) {
        if(message.data.isNotEmpty) {
          print(message.data);
          print("------------------");
        }
        showNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      print('Background State Notification');
      if (message != null && message.data.isNotEmpty) {
        print(message.data);
        print("------------------");
        FcmNavigation.handleBackgroundStateNavigation(message.data);
      }
    });
  }

  Future<void> initLocalNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(sound: true, badge: true, alert: true);

    //Needed by iOS only
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true,);
    }
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          print('OnTap');
          if(response.payload != '') {
            FcmNavigation.handleBackgroundStateNavigation(jsonDecode(response.payload!));
          }
        },
        onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse
    );
  }

  static showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel_id', 'Channel Name',
        channelDescription: 'Channel Description',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        number: 1,
        ticker: 'ticker');

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
    );

    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(id, message.notification?.title,
        message.notification?.body, notificationDetails, payload: jsonEncode(message.data));
  }

}