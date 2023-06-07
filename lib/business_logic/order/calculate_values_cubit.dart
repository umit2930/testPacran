import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/success_model.dart';
import 'package:dobareh_bloc/data/repository/order_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../data/model/calculate_values/CalculateValuesBody.dart';
import '../../data/model/calculate_values/CategoriesResponse.dart';

part 'calculate_values_state.dart';

class CalculateValuesCubit extends Cubit<CalculateValuesState> {
  CalculateValuesCubit({required int orderID})
      : _orderRepository = Get.find(),
        super(CalculateValuesState(
            calculateValuesStatus: CalculateValuesStatus.init,
            orderID: orderID,
            addedValues: const {}));

  final OrderRepository _orderRepository;

  void categoriesRequested() async {
    emit(state.copyWith(calculateValuesStatus: CalculateValuesStatus.loading));
    try {
      var response = await _orderRepository.getCategories();
      emit(state.copyWith(
          calculateValuesStatus: CalculateValuesStatus.success,
          categoriesResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          calculateValuesStatus: CalculateValuesStatus.error,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          calculateValuesStatus: CalculateValuesStatus.error,
          errorMessage: e.toString()));
    }
  }

  void valuesSubmitted() async {
    emit(state.copyWith(calculateValuesStatus: CalculateValuesStatus.loading));
    try {
      var response = await _orderRepository.calculateValues(
          state.orderID, state.addedValues);
      emit(state.copyWith(
          calculateValuesStatus: CalculateValuesStatus.success,
          calculateValuesResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          calculateValuesStatus: CalculateValuesStatus.error,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          calculateValuesStatus: CalculateValuesStatus.error,
          errorMessage: e.toString()));
    }
  }

  void valueAdded(MaterialCategories category, Items item) async {
    var addedValues = Map<MaterialCategories, Items>.from(state.addedValues);
    addedValues[category] = item;
    emit(state.copyWith(addedValues: addedValues));
  }

  void valueDeleted(MaterialCategories category) async {
    var addedValues = Map<MaterialCategories, Items>.from(state.addedValues);
    addedValues.remove(category);
    emit(state.copyWith(addedValues: addedValues));
  }

  void valueUpdated(MaterialCategories category, Items item) async {
    var addedValues = Map<MaterialCategories, Items>.from(state.addedValues);
    addedValues[category] = item;
    emit(state.copyWith(addedValues: addedValues));
  }
}
