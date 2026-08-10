import "package:equatable/equatable.dart";

import "local_notification_entity.dart";

/// Entity that contains the LocalNotification values.
class LocalNotificationGroupEntity extends Equatable {
  /// Entity that contains the LocalNotification values.
  const LocalNotificationGroupEntity({
    required this.user,
    required this.notifications,
  });

  /// User the notification belongs to
  final String user;

  /// List of notifications
  final List<LocalNotificationEntity> notifications;

  @override
  List<Object?> get props => [
        user,
        notifications,
      ];

  @override
  bool get stringify => true;
}
