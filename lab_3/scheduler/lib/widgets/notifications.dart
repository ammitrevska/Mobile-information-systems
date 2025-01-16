import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the notification plugin
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings);
  }

  // Show a notification
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'main_channel',
      'Main Channel',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(id, title, body, details);
  }
}

// Setup geofencing with notifications
void setupGeofenceNotifications() {
  // Initialize notifications
  NotificationHelper.initialize();

  // Listen for geofence events
  bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) async {
    if (event.action == "ENTER") {
      // Trigger a notification when entering the geofence
      await NotificationHelper.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/
            1000, // Unique ID for notification
        title: "Exam Reminder",
        body: "You're near the location of your exam: ${event.identifier}",
      );
    }
  });
}
