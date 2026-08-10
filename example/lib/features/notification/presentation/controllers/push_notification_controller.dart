import "package:flutter_common_classes/constants/classes/params.dart";
import "package:get_it/get_it.dart";

import "../../notification.dart";

/// [PushNotificationController] is a controller class that is responsible for handling the notification feature.
class PushNotificationController {
  /// Sends a schedule push notification
  static void sendLocalPushNotification({
    required SendLocalPushNotificationParams params,
  }) =>
      SendLocalPushNotification(
        repository: GetIt.I<PushNotificationRepository>(),
      ).call(
        params: params,
      );

  /// Cancels all the notifications
  static void cancelAllNotifications() => CancelLocalPushNotifications(
        repository: GetIt.I<PushNotificationRepository>(),
      ).call(
        params: const NoParams(),
      );
}
