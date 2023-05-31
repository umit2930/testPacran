part of 'timer_cubit.dart';

enum TimerStatus {
  initial,
  inProgress, complete }

final class TimerState {
  final int tiks;
  final TimerStatus timerStatus;

  const TimerState._({required this.timerStatus,required this.tiks});

  const TimerState.initial(int duration)
      : this._(timerStatus: TimerStatus.initial, tiks: 0);

  const TimerState.inProgress(int duration)
      : this._(timerStatus: TimerStatus.inProgress, tiks: duration);

  const TimerState.complete() : this._(timerStatus: TimerStatus.complete,tiks: 0);
}
