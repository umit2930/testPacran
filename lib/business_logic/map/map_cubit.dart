import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/home/home_response.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(Map<DeliveryTime, List<Orders>> timePacks,Orders? inProgressOrder,int selectedTime)
      : super(MapState(timePacks: timePacks,inProgressOrder: inProgressOrder, selectedTime: selectedTime));

  void timeSelected(int selectedTime) {
    emit(state.copyWith(selectedTime: selectedTime,selectedOrder: 0));
  }

  void orderSelected(int selectedOrder) {
    emit(state.copyWith(selectedOrder: selectedOrder));
  }
}
