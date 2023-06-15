import 'package:dobareh_bloc/data/data_provider/remote/order/order_api_provider.dart';
import 'package:dobareh_bloc/data/repository/order_repository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../data/data_provider/local/auth_shared_preferences.dart';
import '../data/data_provider/remote/auth/auth_api_provider.dart';
import '../data/data_provider/remote/order/user_api_provider.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/user_repository.dart';

const userTokenTag = "user_token";

class DependencyInjection {
  static Future<void> provideAuth() async {
    Get.lazyPut<AuthApiProvider>(() => AuthApiProvider());
    await Get.putAsync(() async => await AuthSharedPreferences.getInstance());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
  }

  static void provideUserToken(String token)  {
    Get.put(token, tag: userTokenTag);
  }

  //TODO why when we use lazyPut, its not work when go to the screen again ?
  static void provideHome() {
    Get.put(UserApiProvider());
    Get.put<UserRepository>(UserRepository());
  }

  static void provideOrder() {
    Logger().w("provide orders");
    Get.put(OrderApiProvider());
    Get.put(OrderRepository());
  }
}
