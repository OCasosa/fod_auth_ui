import "dart:async";
import "dart:io";

import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:flutter_timezone/flutter_timezone.dart";
import "package:timezone/data/latest_all.dart" as tz;
import "package:timezone/timezone.dart" as tz;

import "../../models/params/params.dart";

/// This class is used to handle the local data source of the push notification.
abstract class PushNotificationLocalDataSource {
  /// Asks the permissions to send notifications
  ///
  /// Returns true if the permissions were granted
  Future<bool> askNotificationPermissions();

  /// Checks if the permissions to send notifications are granted
  Future<bool> getPermission();

  /// Sends a local push notification to the device
  ///
  /// Returns the id of the notification
  bool sendLocalNotification({
    required SendLocalPushNotificationParams params,
  });

  /// Cancels all the notifications
  Future<bool> cancelAllNotifications();
}

const String _notificationsBundleId = "mx.fintechondemand.onewalletbusiness";

/// Implementation of the [PushNotificationLocalDataSource]
class PushNotificationLocalDataSourceImpl
    implements PushNotificationLocalDataSource {
  /// Implementation of the [PushNotificationLocalDataSource]
  PushNotificationLocalDataSourceImpl({
    required this.sendProvider,
    required this.backgroundColor,
  }) {
    _initializeTimeZone();
    if (Platform.isAndroid) {
      _initAndroidConfig();
    } else if (Platform.isIOS) {
      _initIOSConfig();
    }
  }

  /// The provider that sends the notifications to the device
  final FlutterLocalNotificationsPlugin sendProvider;

  /// Background color of the notification
  final Color backgroundColor;

  final Logger _logger = getLogger("Push Notification Local Data Source");

  ///The android notification channel group
  final AndroidNotificationChannelGroup _androidNotificationChannelGroup =
      const AndroidNotificationChannelGroup(
    _notificationsBundleId,
    "Notificaciones de One Wallet Business",
    description: "Notificaciones enviadas por One Wallet Business",
  );

  ///The android notification channel
  final AndroidNotificationChannel _androidNotificationChannel =
      const AndroidNotificationChannel(
    "one_wallet_business_push_notifications_service",
    "Notificaciones de One Wallet Business",
    description: "Notificaciones enviadas por One Wallet Business",
    importance: Importance.high,
    groupId: _notificationsBundleId,
  );

  //Returns the platform notification styles details
  NotificationDetails get _notificationDetails => NotificationDetails(
        android: AndroidNotificationDetails(
          _androidNotificationChannel.id,
          _androidNotificationChannel.name,
          channelDescription: _androidNotificationChannel.description,
          importance: _androidNotificationChannel.importance,
          color: backgroundColor,
          priority: Priority.high,
          groupKey: _androidNotificationChannel.groupId,
          styleInformation: const BigTextStyleInformation(""),
          // setAsGroupSummary: true,
        ),
        iOS: const DarwinNotificationDetails(
          threadIdentifier: _notificationsBundleId,
        ),
      );

  /// Initializes the time zone
  Future _initializeTimeZone() async {
    try {
      tz.initializeTimeZones();

      tz.setLocalLocation(
        tz.getLocation(
          (await FlutterTimezone.getLocalTimezone()).identifier,
        ),
      );
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        CacheException(
          title: "notificationTimeZoneError".tr(),
          message: e.toString(),
        ),
        stackTrace,
      );
    }
  }

  /// Initializes the android configuration
  void _initAndroidConfig() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@drawable/ic_notif");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    sendProvider.initialize(initializationSettings);

    final androidProvider = sendProvider.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    androidProvider
        ?.createNotificationChannelGroup(_androidNotificationChannelGroup);

    androidProvider?.createNotificationChannel(_androidNotificationChannel);
  }

  /// Initializes the ios configuration
  void _initIOSConfig() {
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
    );

    sendProvider.initialize(initializationSettings);
  }

  @override
  Future<bool> askNotificationPermissions() async {
    try {
      if (Platform.isAndroid) {
        final permission = await sendProvider
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.requestNotificationsPermission() ??
            false;

        final schedulePermission = await sendProvider
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.requestExactAlarmsPermission() ??
            false;

        return permission && schedulePermission;
      } else if (Platform.isIOS) {
        return await sendProvider
                .resolvePlatformSpecificImplementation<
                    IOSFlutterLocalNotificationsPlugin>()
                ?.requestPermissions(
                  alert: true,
                  badge: true,
                  sound: true,
                ) ??
            false;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        CacheException(
          title: "notificationPermissionError".tr(),
          message: e.toString(),
        ),
        stackTrace,
      );
    }
  }

  @override
  Future<bool> getPermission() async {
    try {
      if (Platform.isAndroid) {
        final permission = await sendProvider
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.areNotificationsEnabled() ??
            false;

        final schedulePermission = await sendProvider
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.canScheduleExactNotifications() ??
            false;

        _logger.i(
          "Notification permission status: $permission, Schedule permission status: $schedulePermission",
        );

        return permission && schedulePermission;
      } else if (Platform.isIOS) {
        return (await sendProvider
                    .resolvePlatformSpecificImplementation<
                        IOSFlutterLocalNotificationsPlugin>()
                    ?.checkPermissions())
                ?.isEnabled ??
            false;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        CacheException(
          title: "notificationPermissionError".tr(),
          message: e.toString(),
        ),
        stackTrace,
      );
    }
  }

  @override
  Future<bool> cancelAllNotifications() async {
    try {
      await sendProvider.cancelAll();

      return true;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        CacheException(
          title: "notificationsCancelError".tr(),
          message: e.toString(),
        ),
        stackTrace,
      );
    }
  }

  @override
  bool sendLocalNotification({
    required SendLocalPushNotificationParams params,
  }) {
    _logger.i(
      "Showing notification: ${params.title}, delayed by: ${params.delay?.inSeconds} seconds",
    );

    try {
      if (params.delay == null) {
        sendProvider.show(
          params.id,
          params.title,
          params.message,
          _notificationDetails,
        );
      } else {
        final delayed = tz.TZDateTime.now(tz.local).add(params.delay!);

        _logger.i("Scheduling notification for: $delayed");

        sendProvider.zonedSchedule(
          params.id,
          params.title,
          params.message,
          delayed,
          _notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        );
      }

      return true;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        CacheException(
          title: "notificationSendError".tr(),
          message: e.toString(),
        ),
        stackTrace,
      );
    }
  }
}
