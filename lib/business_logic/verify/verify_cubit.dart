import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../utils/app_exception.dart';
import '../../data/model/auth/verify_response.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit({required String initNumber, required int initRemaining})
      : _authRepository = Get.find(),
        super(VerifyState(
            verifyStatus: VerifyStatus.initial,
            initNumber: initNumber,
            initRemaining: initRemaining));

  final AuthRepository _authRepository;

  void codeChanged(String code) {
    emit(state.copyWith(code: code));
  }

  void verifySubmitted(String number, String code) async {
    try {
      emit(state.copyWith(verifyStatus: VerifyStatus.loading));
      VerifyResponse verifyResponse =
          await _authRepository.verify(number, code);
      await _authRepository.saveToken(verifyResponse.token ?? "");
      emit(state.copyWith(
          verifyStatus: VerifyStatus.success, verifyResponse: verifyResponse));
    } on AppException catch (e) {
      emit(state.copyWith(
          verifyStatus: VerifyStatus.failure, errorMessage: e.toString()));
    } catch (e) {
      emit(state.copyWith(
          verifyStatus: VerifyStatus.failure,
          errorMessage: "unknown: ${e.toString()}"));
    }
  }
}
