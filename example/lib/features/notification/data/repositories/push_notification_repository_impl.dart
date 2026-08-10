import "package:flutter_common_classes/errors/failure.dart";
import "package:fpdart/fpdart.dart";

import "../../../../core/errors/error_handler.dart";
import "../../business/repositories/push_notification_repository.dart";
import "../data_sources/local/push_notification_local_data_source.dart";
import "../models/params/send_local_push_notification_params.dart";

/// Repository for push notifications operations
class PushNotificationRepositoryImpl implements PushNotificationRepository {
  /// Repository for push notifications operations
  PushNotificationRepositoryImpl({
    required this.localDataSource,
  });

  /// The local data source of the push notification
  final PushNotificationLocalDataSource localDataSource;

  @override
  Future<Either<Failure, bool>> askNotificationPermissions() =>
      ErrorHandler.handleCacheCallAsync(
        localDataSource.askNotificationPermissions,
      );

  @override
  Future<Either<Failure, bool>> getPermission() =>
      ErrorHandler.handleCacheCallAsync(
        localDataSource.getPermission,
      );

  @override
  Future<Either<Failure, bool>> cancelAllNotifications() =>
      ErrorHandler.handleCacheCallAsync(
        localDataSource.cancelAllNotifications,
      );

  @override
  Either<Failure, bool> sendLocalNotification({
    required SendLocalPushNotificationParams params,
  }) =>
      ErrorHandler.handleCacheCall(
        () => localDataSource.sendLocalNotification(params: params),
      );
}
