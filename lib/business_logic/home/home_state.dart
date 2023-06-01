part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  const HomeState({
    required this.homeStatus,
    this.homeResponse,
    this.errorMessage,
    this.inProgressOrder,
    this.timePacks,
    this.selectedTimePackID = 0,
  });

  final HomeStatus homeStatus;
  final HomeResponse? homeResponse;
  final String? errorMessage;

  final Map<DeliveryTime, List<Orders>>? timePacks;
  final Orders? inProgressOrder;
  final int selectedTimePackID;

  HomeState copyWith({
    HomeStatus? homeStatus,
    HomeResponse? homeResponse,
    String? errorMessage,
    Map<DeliveryTime, List<Orders>>? timePacks,
    Orders? inProgressOrder,
    int? selectedTimePackID,
  }) {
    return HomeState(
      homeStatus: homeStatus ?? this.homeStatus,
      homeResponse: homeResponse ?? this.homeResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      timePacks: timePacks ?? this.timePacks,
      inProgressOrder: inProgressOrder ?? this.inProgressOrder,
      selectedTimePackID: selectedTimePackID ?? this.selectedTimePackID,
    );
  }
/*
  const HomeState.initial() : this._(homeStatus: HomeStatus.initial);

  const HomeState.loading() : this._(homeStatus: HomeStatus.loading);

  const HomeState.success(HomeResponse homeResponse)
      : this._(homeStatus: HomeStatus.success, homeResponse: homeResponse);

  const HomeState.failure(String message)
      : this._(homeStatus: HomeStatus.failure, errorMessage: message);*/
}
