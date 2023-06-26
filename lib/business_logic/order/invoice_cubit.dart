import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/success_model.dart';
import 'package:dobareh_bloc/data/repository/order_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../data/model/calculate_values/calculate_values_body.dart';
import '../../data/model/calculate_values/categories_response.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit(
      {required int orderID,
      required Map<MaterialCategories, Items> addedValues})
      : _orderRepository = Get.find(),
        super(InvoiceState(
            submitValuesStatus: SubmitValuesStatus.init,
            orderID: orderID,
            addedValues: addedValues));

  final OrderRepository _orderRepository;

  void valuesSubmitted() async {
    emit(state.copyWith(submitValuesStatus: SubmitValuesStatus.loading));
    try {
      var response = await _orderRepository.calculateValues(
          state.orderID, state.addedValues);
      emit(state.copyWith(
          submitValuesStatus: SubmitValuesStatus.success,
          calculateValuesResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          submitValuesStatus: SubmitValuesStatus.error,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          submitValuesStatus: SubmitValuesStatus.error,
          errorMessage: e.toString()));
    }
  }
}
