part of 'map_cubit.dart';

class MapState extends Equatable {
  final int selectedTime;

  final int selectedOrder;
  final Map<DeliveryTime, List<Orders>> timePacks;

  final Orders? inProgressOrder;


  const MapState(
      {required this.selectedTime, this.selectedOrder = 0, required this.timePacks,required this.inProgressOrder,});

  @override
  List<Object?> get props => [selectedTime, selectedOrder, timePacks,inProgressOrder];

  MapState copyWith({
    int? selectedTime,
    int? selectedOrder,
    Map<DeliveryTime, List<Orders>>? timePacks,
    Orders? inProgressOrder,
  }) {
    return MapState(
      selectedTime: selectedTime ?? this.selectedTime,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      timePacks: timePacks ?? this.timePacks,
      inProgressOrder: inProgressOrder ?? this.inProgressOrder,
    );
  }
}
