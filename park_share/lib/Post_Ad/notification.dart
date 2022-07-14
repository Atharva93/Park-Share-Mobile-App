import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:park_share/User_ViewPages/view_bought_qrcodes.dart';

class NotificationApi {
  BuildContext context;
  late FlutterLocalNotificationsPlugin notification;

  NotificationApi(this.context) {
    initNotification();
  }

  //initialize notification
  initNotification() {
    notification = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings iOSInitializationSettings =
        IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    notification.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future showNotification() async {
    var android = AndroidNotificationDetails("channelId", "channelName",
        priority: Priority.high, importance: Importance.max);
    var platformDetails = NotificationDetails(android: android);
    await notification.show(100, "Success!",
        "Your ad has successfully been posted", platformDetails,
        payload: "demo");
  }

  Future<String?> selectNotification(String? payload) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewQrCodes(),
      ),
    );
  }
}
