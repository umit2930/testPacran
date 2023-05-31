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
      : super(VerifyState.initial(initNumber, initRemaining));

  AuthRepository authRepository;

  void verify(String number, String code) async {
    try {
      emit(const VerifyState.loading());
      VerifyResponse verifyResponse = await authRepository.verify(number, code);
      await authRepository.saveToken(verifyResponse.token ?? "");
      await authRepository.getToken();
      emit(VerifyState.success(verifyResponse));
    } on AppException catch (e) {
      emit(VerifyState.failure(e.toString()));
    } catch (e) {
      emit(VerifyState.failure("unknown: ${e.toString()}"));
    }
  }
}
