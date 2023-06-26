import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/data_provider/remote/order/order_api_provider.dart';
import 'package:dobareh_bloc/utils/dependency_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repository.dart';
import '../../data/data_provider/remote/order/user_api_provider.dart';
import '../../data/repository/order_repository.dart';
import '../../data/repository/user_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit()
      : _authRepository = Get.find(),
        super(const AuthenticationState(
          authenticationStatus: AuthenticationStatus.initial,
        ));

  final AuthRepository _authRepository;

  void authRequested() async {
    var userToken = await _authRepository.getToken();
    emit(state.copyWith(
        userToken: userToken,
        authenticationStatus: userToken != null
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated));
  }




  void logoutRequested() async {
    await _authRepository.removeToken();
    Get.delete<String>(tag: userTokenTag);

    //TODO find other way
    Get.delete<UserApiProvider>();
    Get.delete<UserRepository>();
    Get.delete<OrderRepository>();
    Get.delete<OrderApiProvider>();
    var userToken = await _authRepository.getToken();
    emit(state.copyWith(
        userToken: userToken,
        authenticationStatus: userToken != null
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated));
  }
}
