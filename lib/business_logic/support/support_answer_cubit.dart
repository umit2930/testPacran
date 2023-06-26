import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/support/support_answer_response.dart';
import 'package:dobareh_bloc/data/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../utils/app_exception.dart';

part 'support_answer_state.dart';

class SupportAnswerCubit extends Cubit<SupportAnswerState> {
  SupportAnswerCubit(int selectedSupportID)
      : _userRepository = Get.find(),
        super(SupportAnswerState(
            selectedSupportID: selectedSupportID,
            supportAnswerStatus: SupportAnswerStatus.initial));

  final UserRepository _userRepository;

  void supportAnswerRequested() async {
    try {
      emit(state.copyWith(supportAnswerStatus: SupportAnswerStatus.loading));
      var response = await _userRepository.getSupportsAnswer(state.selectedSupportID);
      emit(state.copyWith(
          supportAnswerStatus: SupportAnswerStatus.success,
          supportAnswerResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          supportAnswerStatus: SupportAnswerStatus.failure,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          supportAnswerStatus: SupportAnswerStatus.failure,
          errorMessage: e.toString()));
    }
  }
}
