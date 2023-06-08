import 'package:dobareh_bloc/business_logic/order/change_order_status_cubit.dart';
import 'package:dobareh_bloc/presentation/components/general/loading_widget.dart';
import 'package:dobareh_bloc/presentation/pages/calculate_values_page.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../business_logic/order/order_details_cubit.dart';
import '../../../utils/colors.dart';
import '../../../utils/enums.dart';
import '../general/canceled_dialog.dart';
import '../general/confirm_cancel_dialog.dart';
import '../general/custom_filled_button.dart';
import '../general/custom_outlined_button.dart';
import 'communication_widget.dart';

class BottomActionsWidget extends StatelessWidget {
  const BottomActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeOrderStatusCubit, ChangeOrderStatusState>(
        builder: (context, state) {
      if (state.changeOrderStatus == ChangeOrderStatus.loading) {
        return SizedBox(height: 120.h, child: const LoadingWidget());
      }
      if (state.changeOrderStatus == ChangeOrderStatus.error) {
        context.showToast(
            message: state.errorMessage, messageType: MessageType.error);
      }

      return BottomActionsContent(
          //TODO if code reach here, orderStatus will not null.
          orderStatus: state.orderStatus ?? OrderStatus.waiting);
    });
  }
}

class BottomActionsContent extends StatelessWidget {
  const BottomActionsContent({Key? key, required this.orderStatus})
      : super(key: key);

  final OrderStatus orderStatus;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    switch (orderStatus) {
      case OrderStatus.waiting:
        return Container(
            height: 120.h,
            decoration: topRoundedBoxDecoration,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomFilledButton(
                    onPressed: () {
                      context
                          .read<ChangeOrderStatusCubit>()
                          .changeStatus(orderStatus: OrderStatus.onWay);
                    },
                    buttonChild: const Text("شروع حرکت"),
                    width: 158.w),
                const CommunicationWidget()
              ],
            ));
      case OrderStatus.onWay:
        return Container(
            height: 120.h,
            decoration: topRoundedBoxDecoration,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomFilledButton(
                    onPressed: () {
                      context
                          .read<ChangeOrderStatusCubit>()
                          .changeStatus(orderStatus: OrderStatus.inLocation);
                    },
                    buttonChild: const Text("به مقصد رسیدم"),
                    width: 158.w),
                const CommunicationWidget()
              ],
            ));
      case OrderStatus.inLocation:
        return Container(
          height: 180.h,
          decoration: topRoundedBoxDecoration,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 23.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CommunicationWidget(),
                  CustomOutlinedButton(
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return const ConfirmCancelDialog();
                            }).then((value) {
                          if (value == true) {
                            context.read<ChangeOrderStatusCubit>().changeStatus(
                                orderStatus: OrderStatus.rejected,
                                changeReason:
                                    OrderStatusChangeReason.userNotPresent);
                          }
                        });
                      },
                      width: 158.w,
                      buttonChild: Text("فروشنده حضور ندارد",
                          style:
                              textTheme.bodyMedium?.copyWith(color: secondary)))
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 21.h),
                  child: CustomFilledButton(
                      onPressed: () {
                        Get.to(CalculateValuesPage.router((context
                                    .read<OrderDetailsCubit>()
                                    .state
                                    .orderResponse
                                    ?.order
                                    ?.id ??
                                0)
                            .round()));
                      },
                      buttonChild: const Text("دریافت پسماند"),
                      width: double.infinity),
                ),
              ),
            ],
          ),
        );
      case OrderStatus.rejected:
        // TODO: Handle Rejected state
        SchedulerBinding.instance.addPostFrameCallback((_) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const CanceledDialog();
              });
        });

        return SizedBox(
            height: 120.h, child: const Center(child: Text("ماموریت لغو شد")));
      case OrderStatus.checkFactor:
        // TODO: Handle checkFactor state - go to waiting page.
        return const Center(child: Text("Check_factor"));
      case OrderStatus.delivered:
      // TODO: this state must not be happen.
        return const Center(child: Text("delivered"));
    }
  }
}
