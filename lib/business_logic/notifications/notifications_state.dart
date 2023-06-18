part of 'notifications_cubit.dart';

enum NotificationsStatus { initial, loading, success, failure }

class NotificationsState extends Equatable {
  final NotificationsStatus notificationsStatus;
  final NotificationsResponse? notificationsResponse;
  final String? errorMessage;

  const NotificationsState(
      {required this.notificationsStatus,
      this.notificationsResponse,
      this.errorMessage});

  @override
  List<Object?> get props =>
      [notificationsResponse, notificationsStatus, errorMessage];

  NotificationsState copyWith({
    NotificationsStatus? notificationsStatus,
    NotificationsResponse? notificationsResponse,
    String? errorMessage,
  }) {
    return NotificationsState(
      notificationsStatus: notificationsStatus ?? this.notificationsStatus,
      notificationsResponse:
          notificationsResponse ?? this.notificationsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
