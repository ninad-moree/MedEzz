import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('icon_small');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {},
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showDelayedNotification(
      {int id = 0,
      required DateTime schedule,
      String? title,
      required String medicationName,
      String? payLoad}) async {
    log('Notification scheduled for: $schedule');
    return Future.delayed(schedule.difference(DateTime.now()), () async {
      await notificationsPlugin.show(
        id,
        title ?? 'Medication Reminder',
        "It's time to take $medicationName!",
        await notificationDetails(),
        payload: payLoad,
      );
    },);
  }
}
