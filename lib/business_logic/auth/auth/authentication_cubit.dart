import 'package:bloc/bloc.dart';

import '../../../data/repository/auth_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required this.authRepository})
      : super(authRepository.userToken != ""
            ? AuthenticationState.authenticated(authRepository.userToken)
            : const AuthenticationState.unauthenticated());

  AuthRepository authRepository;


  void userChanged(){
    emit(authRepository.userToken != ""
        ? AuthenticationState.authenticated(authRepository.userToken)
        : const AuthenticationState.unauthenticated());
  }

}
