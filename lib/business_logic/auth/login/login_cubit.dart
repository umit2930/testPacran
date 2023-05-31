import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/auth/login/LoginResponse.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';

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
          loginMessage: e.toString(), loginStatus: LoginStatus.failure));
    } catch (e) {
      emit(state.copyWith(
          loginMessage: e.toString(), loginStatus: LoginStatus.failure));
    }
  }
}
