import 'package:dobareh_bloc/business_logic/order/calculate_values_cubit.dart';
import 'package:dobareh_bloc/business_logic/order/change_order_status_cubit.dart';
import 'package:dobareh_bloc/presentation/components/general/custom_filled_button.dart';
import 'package:dobareh_bloc/presentation/components/general/loading_widget.dart';
import 'package:dobareh_bloc/presentation/pages/waiting_page.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';
import '../../utils/enums.dart';
import '../../utils/icon_assistant.dart';
import '../components/general/canceled_dialog.dart';
import '../components/general/confirm_cancel_dialog.dart';
import '../components/order_details/material_item.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({Key? key}) : super(key: key);

  static Widget router(int orderID, CalculateValuesCubit calculateValuesCubit) {
    return MultiBlocProvider(providers: [
      BlocProvider<CalculateValuesCubit>.value(
        value: calculateValuesCubit,
      ),
      BlocProvider(create: (context) {
        return ChangeOrderStatusCubit(orderID: orderID);
      })
    ], child: const InvoicePage());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        /* Get.off(CalculateValuesPage(
            orderId: orderID,
          ));*/
        return Future.value(true);
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(66.h),
            child: const InvoicePageAppbar()),
        body: MultiBlocListener(
          listeners: [
            ///cancel order
            BlocListener<ChangeOrderStatusCubit, ChangeOrderStatusState>(
              listener: (context, state) {
                if (state.changeOrderStatus == ChangeOrderStatus.loading) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return const LoadingWidget();
                      });
                } else if (state.changeOrderStatus ==
                    ChangeOrderStatus.success) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return const CanceledDialog();
                      });
                }
              },
            ),
            BlocListener<CalculateValuesCubit, CalculateValuesState>(
              listener: (context, state) {
                if (state.submitValuesStatus == SubmitValuesStatus.success) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.offAll(WaitingPage.router(state.orderID));
                  });
                }
              },
            ),
          ],
          child: const InvoicePageBody(),
        ),
      ),
    );
  }
}

class InvoicePageAppbar extends StatelessWidget {
  const InvoicePageAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 8.h, left: 16.w),
        child: Row(
          children: [
            IconAssistant.backIconButton(() => Get.back()),
            Expanded(
              child: Text(
                "فاکتور ثبت شده",
                style: textTheme.bodyMedium?.copyWith(color: secondary),
              ),
            ),
            FilledButton(
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    backgroundColor: secondaryTint2),
                onPressed: () {
                  Get.back();

                  // Get.off(CalculateValuesPage.router());
                },
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/edit.svg"),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Text(
                        "تغییر موارد",
                        style: textTheme.bodyMedium?.copyWith(color: secondary),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class InvoicePageBody extends StatelessWidget {
  const InvoicePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<CalculateValuesCubit, CalculateValuesState>(
      builder: (context, state) {
        var addedValues = state.addedValues;
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 18.h, right: 16.w),
                child: Text(
                  "شما مقادیر زیر را برای پسماندهای فروشنده ثبت کردید",
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(color: natural1),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 9.h),
                        child: Text(
                          "پسماند های غیر الکترونیکی",
                          style:
                              textTheme.bodyMedium?.copyWith(color: natural4),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 16.h,
                        ),
                        decoration: BoxDecoration(
                            color: natural8,
                            borderRadius: BorderRadius.circular(12.r)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var category = addedValues.keys.elementAt(index);
                            var value = addedValues.values.elementAt(index);
                            return MaterialItem(
                              title: category.title ?? "عنوان محصول",
                              unit: "کیلو" /*item.unit*/,
                              weight: "${value.value}",
                            );
                          },
                          itemCount: addedValues.length,
                        ),
                      ),

                      ///Total weight
                      Container(
                        margin: EdgeInsets.only(top: 16.h),
                        decoration: BoxDecoration(
                            color: natural8,
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Container(
                            // height: 45.h,

                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 16.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("در مجموع",
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: natural2)),
                                    const Spacer(),
                                    Text(
                                        NumberFormat.decimalPattern()
                                            .format(state.totalWeight),
                                        style: textTheme.titleSmall
                                            ?.copyWith(color: natural2)),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text("کیلو",
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: natural6)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                        ///Total price
                        Container(
                          margin: EdgeInsets.only(top: 16.h),
                          decoration: BoxDecoration(
                              color: natural8,
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Container(
                            // height: 45.h,

                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 16.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("جمع کل پرداختی",
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: natural2)),
                                    const Spacer(),
                                    Text(
                                        NumberFormat.decimalPattern()
                                            .format(state.totalPrice),
                                        style: textTheme.titleSmall
                                            ?.copyWith(color: natural2)),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text("تومان",
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: natural6)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(child: BlocBuilder<CalculateValuesCubit,
                          CalculateValuesState>(
                        builder: (context, state) {
                          if (state.submitValuesStatus ==
                              SubmitValuesStatus.loading) {
                            return const LoadingWidget();
                          }
                          if (state.submitValuesStatus ==
                              SubmitValuesStatus.error) {
                            context.showToast(
                                message: state.errorMessage,
                                messageType: MessageType.error);
                          }
                          return CustomFilledButton(
                              onPressed: () {
                                context
                                    .read<CalculateValuesCubit>()
                                    .valuesSubmitted();
                              },
                              buttonChild: const Text("ارسال مقادیر به کاربر"));
                        },
                      )),
                      Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: FilledButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const ConfirmCancelDialog();
                                }).then((value) {
                              if (value == true) {
                                context
                                    .read<ChangeOrderStatusCubit>()
                                    .statusSubmitted(
                                        orderStatus: OrderStatus.rejected,
                                        changeReason: OrderStatusChangeReason
                                            .disagreement);
                              }
                            });
                          },
                          style: FilledButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 24.w),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
                              backgroundColor: secondaryTint2),
                          child: Text(
                            "لغو",
                            style: textTheme.bodyMedium
                                ?.copyWith(color: secondary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        );
      },
    );
  }
}
