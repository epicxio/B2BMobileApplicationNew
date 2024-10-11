// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:coswan/providers/notificatiion_provider.dart';
import 'package:coswan/screens/notifiactionview.dart';
import 'package:coswan/services/notification_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

// to handle the notification when app is in background but not  and it is a top level function not a class function
@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload: ${message.data}');
  print('jkfknsdksgflksfnglkdfngkjdfgnkjdfgnkjdfgnkjdfgnkdfjg');
}

class PushNotificationService {
  // firebse instance

  final _firebaseMessaging = FirebaseMessaging.instance;

// local notification plugin
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // to handle the notification request
  Future<void> initNotificationPermission() async {
    print('hi notifix');
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User denied permission');
      print('User granted permission: ${settings.authorizationStatus}');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User denied permission');
      print('User granted permission: ${settings.authorizationStatus}');
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  /// to intialise the local notification plugins
  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/launcher_icon");
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
    
        onDidReceiveNotificationResponse: (payload) {
          Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const NotificationView()));
        });
  }

// in  app active state
  void firebaseinitwhileAppActiveState(BuildContext context) {
    // to handle the notification when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Title : ${message.notification?.title}');
      print('Body : ${message.notification?.body}');
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        Provider.of<NotificationProvider>(context, listen: false)
            .notificationCount++;
        print('Message also contained a notification: ${message.notification}');
      }

      if (Platform.isAndroid) {
        // local notification call
        initLocalNotification(context, message);
        // to call the notification collection
        NotificationAPI.notificationApi(context);
        showNotification(message);
      } else {
        // to call the notification collection
        NotificationAPI.notificationApi(context);
        showNotification(message);
      }
    });
  }

// to show the local notification
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notifications',
        importance: Importance.high);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'Coswan Notification Description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, notificationDetails);
    });
  }

// to get the Fcm token
  Future<String> getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token!;
  }

// to refresh the  FCM token
  void tokenRefresh() async {
    _firebaseMessaging.onTokenRefresh.listen(
      (event) {
        print('token refreshed');
        event.toString();
      },
    );
  }

  //handle the notification when the app is in background
  Future<void> setInteractMsg(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // to call the notification collection

      NotificationAPI.notificationApi(context);
      Provider.of<NotificationProvider>(context, listen: false)
          .notificationCount++;

      handleMessage(context, initialMessage);
    }

    // when app is in  background
    FirebaseMessaging.onMessageOpenedApp
        .listen((event) => handleMessage(context, event));
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    // to call the notification collection
    NotificationAPI.notificationApi(context);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const NotificationView()));
  }
}
