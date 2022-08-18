import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';

class NavigationService {
  static var navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }
}

class PushNotificationService {
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();

    //This function handles the click in the notification when the app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((
      RemoteMessage message,
    ) {
      if (message.data['key'] == 'booking') {
        NavigationService().navigateTo(RoutesName.myTrips);
      }
    });
    await enableIOSNotifications();
    await registerNotificationListeners();
  }

  registerNotificationListeners() async {
    final AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var androidSettings =
        const AndroidInitializationSettings('@mipmap/travelsy');

    var iOSSettings = const IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initSetttings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      var notificationMessagePaylode = message;
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;

      // If onMessage is triggered with a notification, construct our own local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
              playSound: true,
            ),
          ),
        );
      }
      flutterLocalNotificationsPlugin.initialize(initSetttings,
          onSelectNotification: (messages) async {
        // This function handles the click in the notification when the app is in foreground
        if (message.data['key'] == 'booking') {
          NavigationService().navigateTo(RoutesName.myTrips);
        }
      });
    });
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  androidNotificationChannel() => const AndroidNotificationChannel(
        'high_importance_channel', 'High Importance Notifications', // id , name
        description: 'This Channel is used for important notification',
        importance: Importance.high,
        playSound: true, enableVibration: true,
      );

  broadcastNotification() {
    FirebaseMessaging.instance.subscribeToTopic('Events');
  }
}
