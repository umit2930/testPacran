part of 'calculate_values_cubit.dart';


//TODO is calling two api in one cubit is correct?
enum CalculateValuesStatus { init, loading, success, error }

enum SubmitValuesStatus { init, loading, success, error }

class CalculateValuesState extends Equatable {
  final CalculateValuesStatus calculateValuesStatus;
  final SubmitValuesStatus submitValuesStatus;

  final CategoriesResponse? categoriesResponse;
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

  const CalculateValuesState({
    required this.calculateValuesStatus,
    required this.submitValuesStatus,
    required this.orderID,
    this.categoriesResponse,
    this.calculateValuesResponse,
    this.errorMessage,
    //TODO where to set default values of state ?
    required this.addedValues,
  });

  CalculateValuesState copyWith({
    CalculateValuesStatus? calculateValuesStatus,
    SubmitValuesStatus? submitValuesStatus,
    CategoriesResponse? categoriesResponse,
    SuccessModel? calculateValuesResponse,
    String? errorMessage,
    int? orderID,
    Map<MaterialCategories, Items>? addedValues,
    int? totalPrice,
    double? totalWeight,
  }) {
    return CalculateValuesState(
      calculateValuesStatus:
          calculateValuesStatus ?? this.calculateValuesStatus,
      submitValuesStatus: submitValuesStatus ?? this.submitValuesStatus,
      categoriesResponse: categoriesResponse ?? this.categoriesResponse,
      calculateValuesResponse:
          calculateValuesResponse ?? this.calculateValuesResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      orderID: orderID ?? this.orderID,
      addedValues: addedValues ?? this.addedValues,
    );
  }

  @override
  List<Object?> get props => [
        calculateValuesStatus,
        submitValuesStatus,
        categoriesResponse,
        calculateValuesResponse,
        errorMessage,
        orderID,
        addedValues,
        totalPrice,
        totalWeight,
      ];
}
