import "package:flutter_common_classes/constants/classes/params.dart";

/// Parameters to send a local push notification
class SendLocalPushNotificationParams extends Params {
  /// Parameters to send a local push notification
  SendLocalPushNotificationParams({
    required this.title,
    required this.message,
    this.delay,
    this.id = 0,
  });

  /// The id of the notification
  final int id;

  /// The title of the notification
  final String title;

  /// The body of the notification
  final String message;

  /// The delay of the notification
  ///
  /// If null the notification will be sent immediately
  final Duration? delay;
}
