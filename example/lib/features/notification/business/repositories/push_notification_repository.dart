import "package:flutter_common_classes/errors/failure.dart";
import "package:fpdart/fpdart.dart";

import "../../data/models/params/params.dart";

/// Repository for push notifications operations
abstract class PushNotificationRepository {
  /// Asks the permissions to send notifications
  ///
  /// Returns true if the permissions were granted
  Future<Either<Failure, bool>> askNotificationPermissions();

  /// Checks if the permissions to send notifications are granted
  Future<Either<Failure, bool>> getPermission();

  /// Sends a local push notification to the device
  ///
  /// Returns the id of the notification
  Either<Failure, bool> sendLocalNotification({
    required SendLocalPushNotificationParams params,
  });

  /// Cancels all the notifications
  Future<Either<Failure, bool>> cancelAllNotifications();
}
