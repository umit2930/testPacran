import 'package:dobareh_bloc/data/data_provider/remote/order/home_api_provider.dart';
import 'package:dobareh_bloc/data/model/home/home_response.dart';
import 'package:dobareh_bloc/data/model/home/profile_response.dart';
import 'package:dobareh_bloc/utils/network_response_to_result.dart';
import 'package:get/get.dart';

class UserRepository {
  final UserApiProvider _userApiProvider;

  UserRepository() : _userApiProvider = Get.find();

  Future<HomeResponse> getHome() async {
    return await NetworkResponseToResult<HomeResponse>().generalNetworkResult(
        HomeResponse.fromJson, _userApiProvider.getHome());
  }

  Future<ProfileResponse> getProfile() async {
    return await NetworkResponseToResult<ProfileResponse>().generalNetworkResult(
        ProfileResponse.fromJson, _userApiProvider.getProfile());
  }
}
