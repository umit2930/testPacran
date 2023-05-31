part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    required this.loginStatus,
    this.loginResponse,
    this.errorMessage,
    this.number = "",
  });

  final LoginStatus loginStatus;
  final LoginResponse? loginResponse;
  final String? errorMessage;

  final String number;

  LoginState copyWith({
    LoginStatus? loginStatus,
    LoginResponse? loginResponse,
    String? errorMessage,
    String? number,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      loginResponse: loginResponse ?? this.loginResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      number: number ?? this.number,
    );
  }

  @override
  List<Object?> get props => [loginStatus, loginResponse, errorMessage, number];

/*

  const LoginState.initial() : this._(loginStatus: LoginStatus.initial);

  const LoginState.loading() : this._(loginStatus: LoginStatus.loading);

  const LoginState.success(LoginResponse loginResponse)
      : this._(loginStatus: LoginStatus.success, loginResponse: loginResponse);

  const LoginState.failure(String message)
      : this._(loginStatus: LoginStatus.failure, loginMessage: message);
*/
}
