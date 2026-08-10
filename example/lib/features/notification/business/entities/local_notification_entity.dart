import "package:equatable/equatable.dart";

/// Entity that contains the LocalNotification values.
class LocalNotificationEntity extends Equatable {
  /// Entity that contains the LocalNotification values.
  const LocalNotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  /// Unique Identifier
  final int id;

  /// Title of the notification
  final String title;

  /// Body of the notification
  final String body;

  /// Date the notification was created
  final DateTime date;

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        date,
      ];

  @override
  bool get stringify => true;
}
