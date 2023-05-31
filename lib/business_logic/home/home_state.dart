part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  const HomeState._({
    required this.homeStatus,
    this.homeResponse,
    this.errorMessage,
  });

  final HomeStatus homeStatus;
  final HomeResponse? homeResponse;
  final String? errorMessage;

  const HomeState.initial() : this._(homeStatus: HomeStatus.initial);

  const HomeState.loading() : this._(homeStatus: HomeStatus.loading);

  const HomeState.success(HomeResponse homeResponse)
      : this._(homeStatus: HomeStatus.success, homeResponse: homeResponse);

  const HomeState.failure(String message)
      : this._(homeStatus: HomeStatus.failure, errorMessage: message);
}
