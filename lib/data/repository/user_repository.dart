import 'package:dobareh_bloc/data/data_provider/remote/order/user_api_provider.dart';
import 'package:dobareh_bloc/data/model/home/home_response.dart';
import 'package:dobareh_bloc/data/model/home/profile_response.dart';
import 'package:dobareh_bloc/data/model/report/ReportResponse.dart';
import 'package:dobareh_bloc/data/model/report/SendReportResponse.dart';
import 'package:dobareh_bloc/data/model/support/SupportAnswerResponse.dart';
import 'package:dobareh_bloc/data/model/support/SupportResponse.dart';
import 'package:dobareh_bloc/utils/network_response_to_result.dart';
import 'package:get/get.dart';

class UserRepository {
  final UserApiProvider _userApiProvider;

  UserRepository() : _userApiProvider = Get.find();

  Future<HomeResponse> getHome() async {
    return await generalNetworkResult<HomeResponse>(
        HomeResponse.fromJson, _userApiProvider.getHome());
  }

  Future<ProfileResponse> getProfile() async {
    return await generalNetworkResult<ProfileResponse>(
        ProfileResponse.fromJson, _userApiProvider.getProfile());
  }

  Future<SupportResponse> getSupports() async {
    return await generalNetworkResult<SupportResponse>(
        SupportResponse.fromJson, _userApiProvider.getSupport());
  }

  Future<SupportAnswerResponse> getSupportsAnswer(int supportID) async {
    return await generalNetworkResult<SupportAnswerResponse>(
        SupportAnswerResponse.fromJson,
        _userApiProvider.getSupportAnswer(supportID));
  }

  Future<ReportResponse> getReports() async {
    return await generalNetworkResult<ReportResponse>(
        ReportResponse.fromJson, _userApiProvider.getReports());
  }

  Future<SendReportResponse> sendReport(int reportID) async {
    return await generalNetworkResult<SendReportResponse>(
        SendReportResponse.fromJson,
        _userApiProvider.sendReport(reportID));
  }
}
