import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit()
      : super(const TimerState(tiks: 0, timerStatus: TimerStatus.initial));

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void startTimer(int duration) {
    _tickerSubscription?.cancel();

    _tickerSubscription = const Ticker().tick(ticks: duration).listen((event) {
      if (event > 0) {
        emit(state.copyWith(tiks: event, timerStatus: TimerStatus.inProgress));
      } else {
        _tickerSubscription?.cancel();

        emit(state.copyWith(timerStatus: TimerStatus.complete, tiks: 0));
      }
    });
  }
}

class Ticker {
  const Ticker();

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
