part of 'timer_cubit.dart';

enum TimerStatus { initial, inProgress, complete }

final class TimerState extends Equatable {
  final int tiks;
  final TimerStatus timerStatus;

  const TimerState({required this.timerStatus, required this.tiks});

  TimerState copyWith({
    int? tiks,
    TimerStatus? timerStatus,
  }) {
    return TimerState(
      tiks: tiks ?? this.tiks,
      timerStatus: timerStatus ?? this.timerStatus,
    );
  }

  @override
  List<Object?> get props => [tiks,timerStatus];
/*
  const TimerState.initial(int duration)
      : this._(timerStatus: TimerStatus.initial, tiks: 0);

  const TimerState.inProgress(int duration)
      : this._(timerStatus: TimerStatus.inProgress, tiks: duration);

  const TimerState.complete() : this._(timerStatus: TimerStatus.complete,tiks: 0);*/
}
