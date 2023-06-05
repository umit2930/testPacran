import 'package:get/get.dart';

import '../data/data_provider/local/auth_shared_preferences.dart';
import '../data/data_provider/remote/auth/auth_api_provider.dart';
import '../data/data_provider/remote/order/home_api_provider.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/home_repository.dart';

const userTokenTag = "user_token";

class DependencyInjection {
  static Future<void> provideAuth() async {
    Get.lazyPut<AuthApiProvider>(() => AuthApiProvider());
    await Get.putAsync(() async => await AuthSharedPreferences.getInstance());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
  }

  static void provideHome(String userToken) async {
    Get.put<String>(userToken, tag: userTokenTag);
    Get.put(HomeApiProvider());
    Get.lazyPut<HomeRepository>(() => HomeRepository());
  }

}
