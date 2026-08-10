import "package:flutter_common_classes/constants/classes/params.dart";
import "package:flutter_common_classes/constants/classes/use_case.dart";
import "package:flutter_common_classes/errors/failure.dart";
import "package:fpdart/fpdart.dart";

import "../repositories/push_notification_repository.dart";

/// Use case for canceling all local push notifications
class CancelLocalPushNotifications extends UseCaseAsync<bool, NoParams> {
  /// Use case for canceling all local push notifications
  CancelLocalPushNotifications({
    required this.repository,
  });

  /// Push notification repository
  final PushNotificationRepository repository;

  @override
  Future<Either<Failure, bool>> call({
    required NoParams params,
  }) async =>
      repository.cancelAllNotifications();
}
