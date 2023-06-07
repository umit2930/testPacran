import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/order/calculate_values_cubit.dart';
import 'category_item.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.read<CalculateValuesCubit>().state;
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return CategoryItem(
          index: index,
        );
      },
      itemCount: state.categoriesResponse?.materialCategories?.length,
    );
  }
}
