import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/home/profile_response.dart';
import 'package:dobareh_bloc/data/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../utils/app_exception.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : _userRepository = Get.find(),
        super(const ProfileState(profileStatus: ProfileStatus.init));

  final UserRepository _userRepository;

  void profileRequested() async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.loading));
      var response = await _userRepository.getProfile();

      emit(state.copyWith(
        profileStatus: ProfileStatus.success,
        profileResponse: response,
      ));
    } on AppException catch (appException) {
      emit(state.copyWith(
          profileStatus: ProfileStatus.error,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          profileStatus: ProfileStatus.error, errorMessage: e.toString()));
    }
  }
}
