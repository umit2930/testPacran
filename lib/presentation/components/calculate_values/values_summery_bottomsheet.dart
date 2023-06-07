import 'package:dobareh_bloc/business_logic/order/calculate_values_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';
import '../general/custom_filled_button.dart';
import '../order_details/material_item.dart';

class ValuesSummeryBottomsheet extends StatelessWidget {
  const ValuesSummeryBottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var state = context.read<CalculateValuesCubit>().state;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
            child: Wrap(
              children: [
                Text("مقادیر وارد شده توسط شما", style: textTheme.bodyLarge),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    top: 16.h,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var category = state.addedValues.keys.elementAt(index);
                    var value = state.addedValues.values.elementAt(index);
                    return MaterialItem(
                      title: category.title ?? "عنوان محصول",
                      unit: "کیلو" /*item.unit*/,
                      weight: "${value.value}",
                    );
                  },
                  itemCount: state.addedValues.length,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
                    children: [
                      Text("در مجموع",
                          style: textTheme.bodyMedium?.copyWith(color: natural2)),
                      Expanded(
                          child: Text("${state.totalWeight}",
                              textAlign: TextAlign.left,
                              style:
                                  textTheme.bodyMedium?.copyWith(color: natural2))),
                      Text(" کیلو",
                          style: textTheme.bodySmall?.copyWith(color: natural6)),
                      Expanded(
                          child: Text(
                              NumberFormat.decimalPattern()
                                  .format(state.totalPrice),
                              textAlign: TextAlign.left,
                              style:
                                  textTheme.bodyMedium?.copyWith(color: natural2))),
                      Text(" تومان",
                          style: textTheme.bodySmall?.copyWith(color: natural6)),
                    ],
                  ),
                ),
                CustomFilledButton(
                    width: double.infinity,
                    onPressed: () {
                      Get.back();
                    },
                    buttonChild: const Text("بازگشت"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
