part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState {
  const LoginState({
    required this.loginStatus,
    this.loginResponse,
    this.loginMessage,
  });

  final LoginStatus loginStatus;
  final LoginResponse? loginResponse;
  final String? loginMessage;

  LoginState copyWith({
    required LoginStatus loginStatus,
    LoginResponse? loginResponse,
    String? loginMessage,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      loginResponse: loginResponse ?? this.loginResponse,
      loginMessage: loginMessage ?? this.loginMessage,
    );
  }
/*

  const LoginState.initial() : this._(loginStatus: LoginStatus.initial);

  const LoginState.loading() : this._(loginStatus: LoginStatus.loading);

  const LoginState.success(LoginResponse loginResponse)
      : this._(loginStatus: LoginStatus.success, loginResponse: loginResponse);

  const LoginState.failure(String message)
      : this._(loginStatus: LoginStatus.failure, loginMessage: message);
*/
}
