import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/auth_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required this.authRepository})
      : super(const AuthenticationState(
          authenticationStatus: AuthenticationStatus.initial,
        ));

  AuthRepository authRepository;

  void authRequested() async {
    var userToken = await authRepository.getToken();
    emit(state.copyWith(
        userToken: userToken,
        authenticationStatus: userToken != null
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated));
  }
}
