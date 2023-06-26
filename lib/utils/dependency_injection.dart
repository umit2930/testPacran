import 'package:dobareh_bloc/data/data_provider/remote/order/order_api_provider.dart';
import 'package:dobareh_bloc/data/repository/order_repository.dart';
import 'package:get/get.dart';

import '../data/data_provider/local/auth_shared_preferences.dart';
import '../data/data_provider/remote/auth/auth_api_provider.dart';
import '../data/data_provider/remote/order/user_api_provider.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/user_repository.dart';

const userTokenTag = "user_token";



class AuthBinding extends Bindings {
  @override
  Future<void> dependencies() async{
    Get.lazyPut<AuthApiProvider>(() => AuthApiProvider(), fenix: true);
    await Get.putAsync(() async => await AuthSharedPreferences.getInstance(),
        permanent: true);
    Get.lazyPut<AuthRepository>(() => AuthRepository(), fenix: true);
  }
}

class HomeOrderBinding extends Bindings {
  HomeOrderBinding(this.token);

  String token;

  @override
  void dependencies() {
    Get.replace(token, tag: userTokenTag);
    Get.put<UserApiProvider>(UserApiProvider(), permanent: true);
    Get.put<UserRepository>(UserRepository(), permanent: true);
    Get.put<OrderApiProvider>(OrderApiProvider(), permanent: true);
    Get.put<OrderRepository>(OrderRepository(), permanent: true);
  }
}

class DependencyInjection {
  static Future<void> provideAuth() async {
    Get.lazyPut<AuthApiProvider>(() => AuthApiProvider(), fenix: true);
    await Get.putAsync(() async => await AuthSharedPreferences.getInstance(),
        permanent: true);
    Get.lazyPut<AuthRepository>(() => AuthRepository(), fenix: true);
  }

  static void provideUserToken(String token) {}

  static void provideHome() {}

  static void provideOrder() {}
}