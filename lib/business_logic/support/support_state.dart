part of 'support_cubit.dart';

enum SupportsStatus { initial, loading, success, failure }

class SupportState extends Equatable {
  final SupportsStatus supportsStatus;
  final String? errorMessage;

  final SupportResponse? supportResponse;

  const SupportState({
    required this.supportsStatus,
    this.errorMessage,
    this.supportResponse,
  });

  @override
  List<Object?> get props => [supportsStatus, supportResponse, errorMessage];

  SupportState copyWith({
    SupportsStatus? supportsStatus,
    String? errorMessage,
    SupportResponse? supportResponse,
    int? selectedSupportID,
    SupportAnswerResponse? supportAnswerResponse,
  }) {
    return SupportState(
      supportsStatus: supportsStatus ?? this.supportsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      supportResponse: supportResponse ?? this.supportResponse,
    );
  }
}
