import 'package:dobareh_bloc/presentation/components/calculate_values/values_summery_bottomsheet.dart';
import 'package:dobareh_bloc/presentation/pages/invoice_page.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../business_logic/order/calculate_values_cubit.dart';
import '../../../utils/colors.dart';
import '../general/custom_filled_button.dart';
import '../general/custom_outlined_button.dart';

class BottomActions extends StatelessWidget {
  const BottomActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<CalculateValuesCubit, CalculateValuesState>(
        builder: (context, state) {
      return Container(
        padding:
            EdgeInsets.only(bottom: 57.h, left: 15.w, right: 15.w, top: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: CustomOutlinedButton(
                width: 156.w,
                onPressed: () {
                  var cubit = context.read<CalculateValuesCubit>();
                  showModalBottomSheet(
                      showDragHandle: true,
                      backgroundColor: white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16.r))),
                      context: context,
                      builder: (context) {
                        return BlocProvider.value(
                          value: cubit,
                          child: const ValuesSummeryBottomsheet(),
                        );
                      });
                },
                buttonChild: Row(
                  children: [
                    SvgPicture.asset("assets/icons/attention.svg"),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                            NumberFormat.decimalPattern()
                                .format(state.totalPrice),
                            textAlign: TextAlign.center,
                            style: textTheme.titleLarge
                                ?.copyWith(color: secondary)),
                      ),
                    ),
                    Text(
                      "تومان",
                      style: textTheme.bodySmall
                          ?.copyWith(fontSize: 12, color: secondary),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              flex: 4,
              child: CustomFilledButton(
                onPressed: () {
                  if (state.totalWeight == 0) {
                    context.showToast(
                      message: "ابتدا مقادیر را وارد کنید.",
                      messageType: MessageType.warning,
                    );
                  } else {
                    Get.off(
                        InvoicePage.router(state.orderID, state.addedValues));
                  }
                },
                buttonChild: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ادامه",
                      style: textTheme.bodyMedium?.copyWith(color: white),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SvgPicture.asset(
                      "assets/icons/arrowc.svg",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
