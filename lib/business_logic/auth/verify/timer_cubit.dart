import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/presentation/auth/code_page.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerState.initial(0));


  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void startTimer(int duration) {
    _tickerSubscription?.cancel();

    _tickerSubscription = Ticker().tick(ticks: duration).listen((event) {
      if (event > 0) {
        emit(TimerState.inProgress(event));
      } else {
        emit(const TimerState.complete());
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
