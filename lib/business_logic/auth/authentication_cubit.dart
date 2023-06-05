import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit()
      : _authRepository = Get.find(),
        super(const AuthenticationState(
          authenticationStatus: AuthenticationStatus.initial,
        ));

  final AuthRepository _authRepository;

  void authRequested() async {
    var userToken = await _authRepository.getToken();
    emit(state.copyWith(
        userToken: userToken,
        authenticationStatus: userToken != null
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated));
  }

  void logoutRequested() async {
    await _authRepository.removeToken();
    var userToken = await _authRepository.getToken();
    emit(state.copyWith(
        userToken: userToken,
        authenticationStatus: userToken != null
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated));
  }
}
