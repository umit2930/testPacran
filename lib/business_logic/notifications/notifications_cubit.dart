import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/notifications/notifications_response.dart';
import 'package:dobareh_bloc/data/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../utils/app_exception.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit()
      : _userRepository = Get.find(),
        super(const NotificationsState(
            notificationsStatus: NotificationsStatus.initial));

  final UserRepository _userRepository;

  void notificationsRequested() async {
    try {
      emit(state.copyWith(notificationsStatus: NotificationsStatus.loading));
      var response = await _userRepository.getNotifications();
      emit(state.copyWith(
          notificationsStatus: NotificationsStatus.success,
          notificationsResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          notificationsStatus: NotificationsStatus.failure,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          notificationsStatus: NotificationsStatus.failure,
          errorMessage: e.toString()));
    }
  }
}
