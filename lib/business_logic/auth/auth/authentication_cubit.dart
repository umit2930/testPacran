import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/auth_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required this.authRepository})
      : super(authRepository.userToken != ""
            ? AuthenticationState(
                userToken: authRepository.userToken,
                authenticationStatus: AuthenticationStatus.authenticated)
            : const AuthenticationState(
                authenticationStatus: AuthenticationStatus.unauthenticated));

  AuthRepository authRepository;

  void userChanged() {
    emit(authRepository.userToken != ""
        ? state.copyWith(
            userToken: authRepository.userToken,
            authenticationStatus: AuthenticationStatus.authenticated)
        : state.copyWith(
            userToken: authRepository.userToken,
            authenticationStatus: AuthenticationStatus.unauthenticated));
  }
}
