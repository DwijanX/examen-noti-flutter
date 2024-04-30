import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void setupFirebaseMessaging(
      Function(String, String) onMessageReceived) async {
    print("Hi");
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);
    print("not status");
    print(notificationSettings.alert);
    _firebaseMessaging.getToken().then((token) {
      print('Firebase Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.data);
      print('Received message: ${message.notification?.title}');
      print('Received message: ${message.notification?.body}');
      onMessageReceived(
          message.notification?.title ?? "", message.notification?.body ?? "");
    });
  }
}
