import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/auth/login/login_response.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/app_exception.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepository})
      : super(const LoginState(loginStatus: LoginStatus.initial));

  AuthRepository authRepository;

  void login(String number) async {
    try {
      emit(state.copyWith(loginStatus: LoginStatus.loading));

      LoginResponse loginResponse = await authRepository.login(number);

      emit(state.copyWith(
          loginStatus: LoginStatus.success, loginResponse: loginResponse));
    } on AppException catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), loginStatus: LoginStatus.failure));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), loginStatus: LoginStatus.failure));
    }
  }

  void numberChanged(String number) {
    emit(state.copyWith(number: number));
  }
}
