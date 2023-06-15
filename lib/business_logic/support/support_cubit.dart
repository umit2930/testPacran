import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/support/SupportAnswerResponse.dart';
import 'package:dobareh_bloc/data/model/support/SupportResponse.dart';
import 'package:dobareh_bloc/data/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../utils/app_exception.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit()
      : _userRepository = Get.find(),
        super(const SupportState(
            supportsStatus: SupportsStatus.initial,));

  final UserRepository _userRepository;

  void supportsRequested() async {
    try {
      emit(state.copyWith(supportsStatus: SupportsStatus.loading));
      var response = await _userRepository.getSupports();
      emit(state.copyWith(
          supportsStatus: SupportsStatus.success, supportResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          supportsStatus: SupportsStatus.failure,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          supportsStatus: SupportsStatus.failure, errorMessage: e.toString()));
    }
  }

}
