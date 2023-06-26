import 'package:dobareh_bloc/business_logic/order/calculate_values_cubit.dart';
import 'package:dobareh_bloc/data/model/calculate_values/calculate_values_body.dart';
import 'package:dobareh_bloc/data/model/calculate_values/categories_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('add values', () {
    test("must start with 0", () {
      expect(CalculateValuesCubit(orderID: 1).state.addedValues.length, 0);
    });

    test('value must be added', () {
      final calculateValuesCubit = CalculateValuesCubit(orderID: 1);
      calculateValuesCubit.valueAdded(
          MaterialCategories(id: 1, title: "آهن", price: "5000"),
          Items(material: 1, value: 50));
      expect(calculateValuesCubit.state.addedValues.length, 1);
    });

    test('value must be removed', () {
      final calculateValuesCubit = CalculateValuesCubit(orderID: 1);
      calculateValuesCubit.valueAdded(
          MaterialCategories(id: 1, title: "آهن", price: "5000"),
          Items(material: 1, value: 50));
      calculateValuesCubit.valueDeleted(
        MaterialCategories(id: 1, title: "آهن", price: "5000"),
      );
      expect(calculateValuesCubit.state.addedValues.length, 0);
    });
  });
}
