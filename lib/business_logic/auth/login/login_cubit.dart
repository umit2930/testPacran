import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/auth/login/LoginResponse.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';

import '../../../utils/app_exception.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepository}) : super(const LoginState.initial());

  AuthRepository authRepository;


  void login(String number) async {
    try {
      emit(const LoginState.loading());

      LoginResponse loginResponse = await authRepository.login(number);


      emit(LoginState.success(loginResponse));


    } on AppException catch (e) {
      emit(LoginState.failure(e.toString()));
    } catch (e) {
      emit(LoginState.failure("unknown: ${e.toString()}"));
    }
  }
}
