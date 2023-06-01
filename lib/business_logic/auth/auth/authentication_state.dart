part of 'authentication_cubit.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

class AuthenticationState extends Equatable {
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
      authenticationStatus: authenticationStatus,
    );
  }

  @override
  List<Object?> get props => [userToken, authenticationStatus];
}
