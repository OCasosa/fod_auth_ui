import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fpdart/fpdart.dart";

import "../../data/models/params/params.dart";
import "../repositories/push_notification_repository.dart";

/// Use case for sending a local push notification
class SendLocalPushNotification
    extends UseCaseAsync<bool, SendLocalPushNotificationParams> {
  /// Use case for sending a local push notification
  SendLocalPushNotification({
    required this.repository,
  });

  /// Repository for push notifications operations
  final PushNotificationRepository repository;

  @override
  Future<Either<Failure, bool>> call({
    required SendLocalPushNotificationParams params,
  }) async {
    final permissionResult = await repository.getPermission();

    late bool permissionStatus;

    permissionResult.fold(
      (l) {
        permissionStatus = false;
      },
      (r) {
        permissionStatus = r;
      },
    );

    if (!permissionStatus) {
      return const Right(false);
    }

    return repository.sendLocalNotification(params: params);
  }
}
