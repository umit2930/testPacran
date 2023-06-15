part of 'support_answer_cubit.dart';

enum SupportAnswerStatus { initial, loading, success, failure }

class SupportAnswerState extends Equatable {
  final SupportAnswerStatus supportAnswerStatus;
  final String? errorMessage;

  final int selectedSupportID;
  final SupportAnswerResponse? supportAnswerResponse;

  const SupportAnswerState(
      {required this.supportAnswerStatus,
      this.errorMessage,
      required this.selectedSupportID,
      this.supportAnswerResponse});

  @override
  List<Object?> get props => [
        supportAnswerStatus,
        supportAnswerResponse,
        errorMessage
      ];

  SupportAnswerState copyWith({
    SupportAnswerStatus? supportAnswerStatus,
    String? errorMessage,
    int? selectedSupportID,
    SupportAnswerResponse? supportAnswerResponse,
  }) {
    return SupportAnswerState(
      supportAnswerStatus: supportAnswerStatus ?? this.supportAnswerStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedSupportID: selectedSupportID ?? this.selectedSupportID,
      supportAnswerResponse:
          supportAnswerResponse ?? this.supportAnswerResponse,
    );
  }
}
