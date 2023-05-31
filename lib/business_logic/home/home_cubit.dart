import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/home/HomeResponse.dart';
import 'package:dobareh_bloc/data/repository/home_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepository}) : super(const HomeState.initial());

  HomeRepository homeRepository;

  void getHome() async {
    try {
      emit(const HomeState.loading());
      var response = await homeRepository.getHome();
      emit(HomeState.success(response));
    } on AppException catch (appException) {
      emit(HomeState.failure(appException.toString()));
    } catch (e) {
      emit(HomeState.failure(e.toString()));
    }
  }
}
