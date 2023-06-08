import 'dart:async';

import 'package:dobareh_bloc/business_logic/order/waiting_cubit.dart';
import 'package:dobareh_bloc/presentation/pages/calculate_values_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../business_logic/order/change_order_status_cubit.dart';
import '../../utils/colors.dart';
import '../../utils/enums.dart';
import '../components/general/canceled_dialog.dart';
import '../components/general/confirm_cancel_dialog.dart';
import '../components/general/loading_widget.dart';
import '../components/waiting_page/dialogs/accepted_by_user_dialog.dart';
import '../components/waiting_page/dialogs/calculate_again_dialog.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({Key? key}) : super(key: key);

  static Widget router(int orderID) {
    return MultiBlocProvider(providers: [
      BlocProvider<WaitingCubit>(
        create: (context) {
          return WaitingCubit(orderID: orderID);
        },
      ),
      BlocProvider(create: (context) {
        return ChangeOrderStatusCubit(orderID: orderID);
      })
    ], child: const WaitingPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: const WaitingBody(),
      ),
    );
  }
}

class WaitingBody extends StatelessWidget {
  const WaitingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    context.read<WaitingCubit>().orderStatusRequested();

    return MultiBlocListener(
      listeners: [
        BlocListener<ChangeOrderStatusCubit, ChangeOrderStatusState>(
          listener: (context, state) {
            if (state.changeOrderStatus == ChangeOrderStatus.loading) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const LoadingWidget();
                  });
            } else if (state.changeOrderStatus == ChangeOrderStatus.success) {
              context.read<WaitingCubit>().orderStatusClosed();
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const CanceledDialog();
                  });
            }
          },
        ),
        BlocListener<WaitingCubit, WaitingState>(
          listener: (context, state) {
            switch (state.orderStatusResponse?.orderStatus) {
              //waiting
              case 1:
                break;
              //success
              case 2:
                context.read<WaitingCubit>().orderStatusClosed();
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const AcceptedByUserDialog();
                    });
                // });

                break;
              //calculate again
              case 3:
                context.read<WaitingCubit>().orderStatusClosed();

                // WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const CalculateAgainDialog();
                    }).then((value) {
                  //if false -> user canceled the order
                  if (value == false) {
                    context.read<ChangeOrderStatusCubit>().statusSubmitted(
                        orderStatus: OrderStatus.rejected,
                        changeReason: OrderStatusChangeReason.disagreement);
                    //if true -> user want to recalculate
                  } else {
                    Get.off(CalculateValuesPage.router(state.orderID));
                  }
                });
                // });
                break;

              //cancelled
              case 4:
                break;
            }
          },
        ),
      ],
      child: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "منتظر باشید",
                style: textTheme.displayMedium?.copyWith(color: yellow),
              ),
              LottieBuilder.asset(
                "assets/anim/hourglass.json",
                height: 200.h,
                fit: BoxFit.fill,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "کاربر در حال تایید مقادیر وزن کشی ‌شده‌است",
                  style: textTheme.bodyLarge?.copyWith(color: primary),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "بعد از تایید مقادیر، ماموریت شما به پایان می‌رسد",
                  style: textTheme.bodyLarge?.copyWith(color: natural2),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 95.h),
                child: SizedBox(
                    child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w)),
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
                                changeReason:
                                    OrderStatusChangeReason.disagreement,
                              );
                        }
                      });
                    },
                    child: Text(
                      "لغو درخواست",
                      style: textTheme.bodyMedium?.copyWith(color: secondary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
