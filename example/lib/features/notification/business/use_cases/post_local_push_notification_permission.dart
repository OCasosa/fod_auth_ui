import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fpdart/fpdart.dart";

import "../repositories/push_notification_repository.dart";

/// Use case for requesting the permissions to send push notifications
class PostLocalPushNotificationPermission extends UseCaseAsync<bool, NoParams> {
  /// Use case for requesting the permissions to send push notifications
  PostLocalPushNotificationPermission({
    required this.repository,
  });

  /// Repository for push notifications operations
  final PushNotificationRepository repository;

  @override
  Future<Either<Failure, bool>> call({
    required NoParams params,
  }) async =>
      repository.askNotificationPermissions();
}
