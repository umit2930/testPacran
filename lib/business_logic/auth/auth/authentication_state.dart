part of 'authentication_cubit.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

 class AuthenticationState {
  const AuthenticationState(
      {this.userToken = "", required this.authenticationStatus});

  final String userToken;
  final AuthenticationStatus authenticationStatus;


  AuthenticationState copyWith({
    String? userToken,
    required AuthenticationStatus authenticationStatus,
  }) {
    return AuthenticationState(
      userToken: userToken ?? this.userToken,
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
    );
  }

/*
  const AuthenticationState.authenticated(String token)
      : this._(
            authenticationStatus: AuthenticationStatus.authenticated,
            userToken: token);

  const AuthenticationState.unauthenticated()
      : this._(authenticationStatus: AuthenticationStatus.unauthenticated);
*/


}
