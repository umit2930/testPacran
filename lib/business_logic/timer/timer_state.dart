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
  List<Object?> get props => [tiks, timerStatus];
}
