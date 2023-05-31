part of 'verify_cubit.dart';

enum VerifyStatus { initial, loading, success, failure }

class VerifyState {
  final VerifyStatus verifyStatus;
  final VerifyResponse? verifyResponse;
  final String? errorMessage;


  ///not nullable ,because cubit cannot work without this values
  final String initNumber;
  final int initRemaining;

  const VerifyState({
    required this.verifyStatus,
    required this.initNumber,
    required this.initRemaining,
    this.verifyResponse,
    this.errorMessage,
  });

  VerifyState copyWith({
    required VerifyStatus verifyStatus,
    VerifyResponse? verifyResponse,
    String? errorMessage,
    String? initNumber,
    int? initRemaining,
  }) {
    return VerifyState(
      verifyStatus: verifyStatus ?? this.verifyStatus,
      verifyResponse: verifyResponse ?? this.verifyResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      initNumber: initNumber ?? this.initNumber,
      initRemaining: initRemaining ?? this.initRemaining,
    );
  }
/*  const VerifyState.initial(String initNumber, int initRemaining)
      : this._(
            verifyStatus: VerifyStatus.initial,
            initNumber: initNumber,
            initRemaining: initRemaining);

  const VerifyState.loading() : this._(verifyStatus: VerifyStatus.loading);

  const VerifyState.success(VerifyResponse verifyResponse)
      : this._(
            verifyStatus: VerifyStatus.success, verifyResponse: verifyResponse);
  const VerifyState.failure(String errorMessage)
      : this._(verifyStatus: VerifyStatus.failure, errorMessage: errorMessage);*/
}
