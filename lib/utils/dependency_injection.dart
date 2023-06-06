import 'package:dobareh_bloc/data/data_provider/remote/order/order_api_provider.dart';
import 'package:dobareh_bloc/data/repository/order_repository.dart';
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

  static void provideUserToken(String token) {
    Get.put(token,tag: userTokenTag);
  }

  static void provideHome() {
    Get.put(HomeApiProvider());
    Get.lazyPut<HomeRepository>(() => HomeRepository());
  }

  static void provideOrder() {
    Get.lazyPut(() => OrderApiProvider());
    Get.lazyPut(() => OrderRepository());
  }
}
