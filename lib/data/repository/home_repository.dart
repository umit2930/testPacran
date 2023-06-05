import 'package:dobareh_bloc/data/data_provider/remote/order/home_api_provider.dart';
import 'package:dobareh_bloc/data/model/home/home_response.dart';
import 'package:dobareh_bloc/utils/network_response_to_result.dart';
import 'package:get/get.dart';

class HomeRepository {
  final HomeApiProvider _homeApiProvider;

  HomeRepository() : _homeApiProvider = Get.find();

  Future<HomeResponse> getHome() async {
    return await NetworkResponseToResult<HomeResponse>().generalNetworkResult(
        HomeResponse.fromJson, _homeApiProvider.getHome());
  }
}
