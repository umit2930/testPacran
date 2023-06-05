part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
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

  @override
  List<Object?> get props => [
        homeStatus,
        homeResponse,
        errorMessage,
        timePacks,
        inProgressOrder,
        selectedTimePackID
      ];
}
