part of 'verify_cubit.dart';

enum VerifyStatus { initial, loading, success, failure }

final class VerifyState {
  final VerifyStatus verifyStatus;
  final VerifyResponse? verifyResponse;
  final String? errorMessage;

  final String? initNumber;
  final int? initRemaining;

  const VerifyState._(
      {required this.verifyStatus,
      this.verifyResponse,
      this.errorMessage,
      this.initNumber,
      this.initRemaining});

  const VerifyState.initial(String initNumber, int initRemaining)
      : this._(
            verifyStatus: VerifyStatus.initial,
            initNumber: initNumber,
            initRemaining: initRemaining);

  const VerifyState.loading() : this._(verifyStatus: VerifyStatus.loading);

  const VerifyState.success(VerifyResponse verifyResponse)
      : this._(
            verifyStatus: VerifyStatus.success, verifyResponse: verifyResponse);
  const VerifyState.failure(String errorMessage)
      : this._(verifyStatus: VerifyStatus.failure, errorMessage: errorMessage);
}
