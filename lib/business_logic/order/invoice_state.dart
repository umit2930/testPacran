part of 'invoice_cubit.dart';

//TODO is calling two api in one cubit is correct?

enum SubmitValuesStatus { init, loading, success, error }

class InvoiceState extends Equatable {
  final SubmitValuesStatus submitValuesStatus;

  final SuccessModel? calculateValuesResponse;

  final String? errorMessage;

  final int orderID;

  ///addedValues
  final Map<MaterialCategories, Items> addedValues;

  int get totalPrice {
    var total = 0;
    addedValues.forEach((category, value) {
      total += ((value.value ?? 0) * num.parse(category.price ?? "0")).round();
    });
    return total;
  }

  double get totalWeight {
    var total = 0.0;
    addedValues.forEach((category, value) {
      total += (value.value ?? 0) as double;
    });
    return total;
  }

  const InvoiceState({
    required this.submitValuesStatus,
    required this.orderID,
    this.calculateValuesResponse,
    this.errorMessage,
    //TODO where to set default values of state ?
    required this.addedValues,
  });

  InvoiceState copyWith({
    SubmitValuesStatus? submitValuesStatus,
    CategoriesResponse? categoriesResponse,
    SuccessModel? calculateValuesResponse,
    String? errorMessage,
    int? orderID,
    Map<MaterialCategories, Items>? addedValues,
    int? totalPrice,
    double? totalWeight,
  }) {
    return InvoiceState(
      submitValuesStatus: submitValuesStatus ?? this.submitValuesStatus,
      calculateValuesResponse:
          calculateValuesResponse ?? this.calculateValuesResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      orderID: orderID ?? this.orderID,
      addedValues: addedValues ?? this.addedValues,
    );
  }

  @override
  List<Object?> get props => [
        submitValuesStatus,
        calculateValuesResponse,
        errorMessage,
        orderID,
        addedValues,
        totalPrice,
        totalWeight,
      ];
}
