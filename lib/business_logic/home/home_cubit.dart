import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/home/home_response.dart';
import 'package:dobareh_bloc/data/repository/home_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepository})
      : super(const HomeState(homeStatus: HomeStatus.initial));

  HomeRepository homeRepository;

  void getHome() async {
    try {
      emit(state.copyWith(homeStatus: HomeStatus.loading));
      var response = await homeRepository.getHome();
      emit(state.copyWith(
          homeStatus: HomeStatus.success, homeResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          homeStatus: HomeStatus.failure,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          homeStatus: HomeStatus.failure, errorMessage: e.toString()));
    }
  }
}
