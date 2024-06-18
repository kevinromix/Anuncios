import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> setFirebase() async {
  // Instanciate Firabase
  final messaging = FirebaseMessaging.instance;
  // Request device permissions
  await messaging.requestPermission();
  // TOKEN
  if (kDebugMode) {
    print(await messaging.getToken());
  }
  // LOCAL NOTIFICATIONS
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );
  final localNotifications = FlutterLocalNotificationsPlugin();
  FirebaseMessaging.onMessage.listen((message) {
    final notification = message.notification;
    if (notification == null) return;
    localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            icon: '@drawable/ic_launcher'),
      ),
      payload: jsonEncode(
        message.toMap(),
      ),
    );
  });
  const android = AndroidInitializationSettings('@drawable/ic_launcher');
  const settings0 = InitializationSettings(android: android);
  await localNotifications.initialize(
    settings0,
  );
  final platform = localNotifications.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();

  await platform?.createNotificationChannel(channel);
}
