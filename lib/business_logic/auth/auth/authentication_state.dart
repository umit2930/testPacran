part of 'authentication_cubit.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

final class AuthenticationState {
  const AuthenticationState._(
      {this.userToken = "", required this.authenticationStatus});

  final String userToken;
  final AuthenticationStatus authenticationStatus;

  const AuthenticationState.authenticated(String token)
      : this._(
            authenticationStatus: AuthenticationStatus.authenticated,
            userToken: token);

  const AuthenticationState.unauthenticated()
      : this._(authenticationStatus: AuthenticationStatus.unauthenticated);
}
