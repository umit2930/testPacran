part of 'report_cubit.dart';

enum ReportStatus { initial, loading, success, failure }

class ReportState extends Equatable {
  final ReportStatus reportStatus;
  final String? errorMessage;
  final ReportResponse? reportResponse;

  const ReportState({
    required this.reportStatus,
    this.errorMessage,
    this.reportResponse,
  });

  @override
  List<Object?> get props => [reportStatus, reportResponse, errorMessage];

  ReportState copyWith({
    ReportStatus? reportStatus,
    String? errorMessage,
    ReportResponse? reportResponse,
  }) {
    return ReportState(
      reportStatus: reportStatus ?? this.reportStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      reportResponse: reportResponse ?? this.reportResponse,
    );
  }
}
