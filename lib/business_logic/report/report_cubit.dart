import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/report/report_response.dart';
import 'package:dobareh_bloc/data/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../utils/app_exception.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit()
      : _userRepository = Get.find(),
        super(const ReportState(
          reportStatus: ReportStatus.initial,
        ));

  final UserRepository _userRepository;

  void reportsRequested() async {
    try {
      emit(state.copyWith(reportStatus: ReportStatus.loading));

      var response = await _userRepository.getReports();
      emit(state.copyWith(
          reportStatus: ReportStatus.success, reportResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          reportStatus: ReportStatus.failure,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          reportStatus: ReportStatus.failure, errorMessage: e.toString()));
    }
  }
}
