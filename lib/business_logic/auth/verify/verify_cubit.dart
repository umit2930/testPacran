import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/auth/login/VerifyResponse.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../utils/app_exception.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit(
      {required this.authRepository,
      required String initNumber,
      required int initRemaining})
      : super(VerifyState(
            verifyStatus: VerifyStatus.initial,
            initNumber: initNumber,
            initRemaining: initRemaining));

  AuthRepository authRepository;

  void verify(String number, String code) async {
    try {
      emit(state.copyWith(verifyStatus: VerifyStatus.loading));
      VerifyResponse verifyResponse = await authRepository.verify(number, code);
      await authRepository.saveToken(verifyResponse.token ?? "");
      await authRepository.getToken();
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
