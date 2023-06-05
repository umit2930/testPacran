part of 'verify_cubit.dart';

enum VerifyStatus { initial, loading, success, failure }

class VerifyState extends Equatable {
  final VerifyStatus verifyStatus;
  final VerifyResponse? verifyResponse;
  final String? errorMessage;

  ///not nullable ,because cubit cannot work without this values
  final String initNumber;
  final int initRemaining;

  final String code;

  const VerifyState({
    required this.verifyStatus,
    required this.initNumber,
    required this.initRemaining,
    this.verifyResponse,
    this.errorMessage,
    this.code = "",
  });

  VerifyState copyWith({
    VerifyStatus? verifyStatus,
    VerifyResponse? verifyResponse,
    String? errorMessage,
    String? initNumber,
    int? initRemaining,
    String? code,
  }) {
    return VerifyState(
      verifyStatus: verifyStatus ?? this.verifyStatus,
      verifyResponse: verifyResponse ?? this.verifyResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      initNumber: initNumber ?? this.initNumber,
      initRemaining: initRemaining ?? this.initRemaining,
      code: code ?? this.code,
    );
  }

  @override
  List<Object?> get props => [
        verifyStatus,
        initNumber,
        initRemaining,
        verifyResponse,
        errorMessage,
        code
      ];
}
