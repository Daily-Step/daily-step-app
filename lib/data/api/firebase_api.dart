import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  //create an instance of Firebase Msg
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for notification',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  //function to init notification
  Future<void> initNotifications() async {
    //request permission from user (will prompt user)
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for this device
    final FCMToken = await _firebaseMessaging.getToken();

    //print the token (normally you would send this to your server)
    print('mattabu: Token: $FCMToken');

    initPushNotifications();
    initLocalNotification();
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings);

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  //function to handle received Msg
  void handleMessage(RemoteMessage? message) {
    //if the message is null , do nothing
    if (message == null) return ;
    print('mattabu: $message');
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    //foreground
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription:  _androidChannel.description,
              icon: '@mipmap/ic_launcher', //android/app/src/main/res/drawable 에 들어있는 아이콘
            ),
          ),
          payload: jsonEncode(message.toMap())
      );
    });
  }
}