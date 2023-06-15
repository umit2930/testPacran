part of 'report_answer_cubit.dart';

enum SendReportStatus { initial, loading, success, failure }

class ReportAnswerState extends Equatable {
  final SendReportStatus sendReportStatus;
  final String? errorMessage;

  final Report report;
  final send_response.SendReportResponse? sendReportResponse;

  const ReportAnswerState(
      {required this.sendReportStatus,
      required this.report,
      this.errorMessage,
      this.sendReportResponse});

  @override
  List<Object?> get props =>
      [sendReportStatus, sendReportResponse, errorMessage];

  ReportAnswerState copyWith({
    SendReportStatus? sendReportStatus,
    String? errorMessage,
    Report? report,
    send_response.SendReportResponse? sendReportResponse,
  }) {
    return ReportAnswerState(
      sendReportStatus: sendReportStatus ?? this.sendReportStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      report: report ?? this.report,
      sendReportResponse: sendReportResponse ?? this.sendReportResponse,
    );
  }
}
