import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../data/model/report/ReportResponse.dart';
import '../../data/model/report/SendReportResponse.dart' as send_response;
import '../../utils/app_exception.dart';

part 'report_answer_state.dart';

class ReportAnswerCubit extends Cubit<ReportAnswerState> {
  ReportAnswerCubit(Report report)
      : _userRepository = Get.find(),
        super(ReportAnswerState(
            sendReportStatus: SendReportStatus.initial, report: report));

  final UserRepository _userRepository;

  void sendReport() async {
    try {
      emit(state.copyWith(sendReportStatus: SendReportStatus.loading));

      var response =
          await _userRepository.sendReport(state.report.id?.round() ?? 0);
      emit(state.copyWith(
          sendReportStatus: SendReportStatus.success,
          sendReportResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          sendReportStatus: SendReportStatus.failure,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          sendReportStatus: SendReportStatus.failure,
          errorMessage: e.toString()));
    }
  }
}
