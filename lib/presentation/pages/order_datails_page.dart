import 'package:dobareh_bloc/business_logic/order/change_order_status_cubit.dart';
import 'package:dobareh_bloc/presentation/components/general/canceled_dialog.dart';
import 'package:dobareh_bloc/presentation/components/general/loading_widget.dart';
import 'package:dobareh_bloc/presentation/components/general/location_checker.dart';
import 'package:dobareh_bloc/presentation/components/general/retry_widget.dart';
import 'package:dobareh_bloc/presentation/components/order_details/bottom_actions_widget.dart';
import 'package:dobareh_bloc/presentation/pages/home_page.dart';
import 'package:dobareh_bloc/presentation/pages/report_page.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:dobareh_bloc/utils/icon_assistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../business_logic/order/order_details_cubit.dart';
import '../../utils/colors.dart';
import '../../utils/enums.dart';
import '../components/general/confirm_cancel_dialog.dart';
import '../components/order_details/material_item.dart';
import '../components/order_details/open_street_map_widget.dart';

enum MenuItem { problem, cancel }

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  static Widget router({required int orderID}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return OrderDetailsCubit(orderID: orderID);
        }),
        BlocProvider(create: (context) {
          return ChangeOrderStatusCubit(orderID: orderID);
        }),
      ],
      child: const OrderDetailsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<OrderDetailsCubit>().orderDetailsRequested();

    return WillPopScope(
      onWillPop: () {
        Get.offAll(HomePage.router());
        return Future.value(false);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.h),
          child: const OrderDetailsAppbar(),
        ),
        body: BlocListener<ChangeOrderStatusCubit, ChangeOrderStatusState>(
          listener: (context, state) {
            if (state.changeOrderStatus == ChangeOrderStatus.loading) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return WillPopScope(
                        onWillPop: () {
                          return Future(() => false);
                        },
                        child: const LoadingWidget());
                  });
            } else if (state.changeOrderStatus == ChangeOrderStatus.success) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const CanceledDialog();
                  });
            } else if (state.changeOrderStatus == ChangeOrderStatus.error) {
              context.showToast(
                  message: state.errorMessage, messageType: MessageType.error);

              ///this close dialog
              Get.back();
            }
          },
          child: const OrderDetailsBody(),
        ),
      ),
    );
  }
}

class OrderDetailsAppbar extends StatelessWidget {
  const OrderDetailsAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        // height: 66.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAssistant.backIconButton(() => Get.offAll(HomePage.router())),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("اطلاعات فروشنده",
                    style: textTheme.bodySmall?.copyWith(color: secondary)),
              ),
            ),
            PopupMenuButton<MenuItem>(
              padding: EdgeInsets.zero,
              onSelected: (MenuItem selected) {
                switch (selected) {
                  case MenuItem.problem:
                    Get.to(ReportPage.router());
                    break;
                  case MenuItem.cancel:
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const ConfirmCancelDialog();
                        }).then((value) {
                      if (value == true) {
                        context.read<ChangeOrderStatusCubit>().statusSubmitted(
                            orderStatus: OrderStatus.rejected,
                            changeReason: OrderStatusChangeReason.problemInWay);
                      }
                    });
                    // TODO: Handle this case.
                    break;
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                        value: MenuItem.problem,
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/warning.svg"),
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Text(
                                "گزارش مشکل",
                                style: textTheme.titleSmall,
                              ),
                            ),
                          ],
                        )),
                    PopupMenuItem(
                        value: MenuItem.cancel,
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/cancel.svg"),
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Text("لغو", style: textTheme.titleSmall),
                            ),
                          ],
                        )),
                  ];
                },
                child: IconAssistant.moreIconButton(),
              ),
            ],
          ),
        ),
    );
  }
}

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({Key? key}) : super(key: key);

  /*Widget lastWidget = const Placeholder();
  OrderResponse model;
  int orderID;*/

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) {
        switch (state.orderDetailsStatus) {
          case OrderDetailsStatus.init:
            context.read<OrderDetailsCubit>().orderDetailsRequested();
            return const LoadingWidget();
          case OrderDetailsStatus.loading:
            return const LoadingWidget();
          case OrderDetailsStatus.error:
            return FailureWidget(
              onRetryPressed: () {
                context.read<OrderDetailsCubit>().orderDetailsRequested();
              },
              errorMessage: state.errorMessage,
            );
          case OrderDetailsStatus.success:
            var order = state.orderResponse!.order;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(children: [
                      ///Code
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: natural8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "کد سفارش",
                              style: textTheme.bodyMedium
                                      ?.copyWith(color: natural4),
                                ),
                                Text(
                                  order!.trackingCode!,
                                  style: textTheme.titleSmall
                                      ?.copyWith(color: natural2),
                                )
                              ],
                            ),
                          ),

                          ///Map
                          Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 182.h,
                                  child: LocationCheckerWidget(
                                    mapWidget: OpenStreetWidget(
                                      order: order,
                                    ),
                                  ),
                                )),
                          ),

                          ///User data
                          Container(
                            margin: EdgeInsets.only(top: 16.h),
                            decoration: boxDecoration,
                            padding: EdgeInsets.symmetric(
                                vertical: 18.h, horizontal: 16.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 8.w, left: 8.w),
                                      child: SvgPicture.asset(
                                          "assets/icons/person.svg"),
                                    ),
                                    Expanded(
                                      child: Text(
                                        order.deliveryPersonName ??
                                            "نام و نام خانوادگی",
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: natural3),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 8.w, left: 8.w, top: 4.h),
                                        child: SvgPicture.asset(
                                            "assets/icons/location.svg"),
                                      ),
                                      Expanded(
                                        child: Text(
                                          order.address?.address ?? "آدرس",
                                          style: textTheme.bodyMedium
                                              ?.copyWith(color: natural1),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 8.w, left: 8.w, top: 4.h),
                                        child: SvgPicture.asset(
                                            "assets/icons/area.svg"),
                                      ),
                                      Text(
                                        "منطقه: ",
                                        style: textTheme.bodyLarge
                                            ?.copyWith(color: natural4),
                                      ),
                                      Expanded(
                                        child: Text(
                                          order.address?.plaque ?? "منطقه",
                                          style: textTheme.bodyMedium
                                              ?.copyWith(color: natural1),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///Weight of items
                          Container(
                            margin: EdgeInsets.only(top: 16.h, bottom: 10.h),
                        decoration: BoxDecoration(
                            color: natural8,
                            borderRadius: BorderRadius.circular(12.r)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var item = order.materialCategories?[index];
                            return MaterialItem(
                              title: item?.title ?? "عنوان",
                              unit: "کیلو" /*item.unit*/,
                              weight: item?.pivot?.value ?? "0",
                            );
                          },
                          itemCount: order.materialCategories?.length ?? 0,
                        ),
                      ),
                    ]),
                  ),
                ),
                BlocProvider(
                    create: (context) {
                      return ChangeOrderStatusCubit(
                          orderID: order.id!.toInt(),
                          orderStatus: OrderStatus.fromString(order.status!));
                    },
                    child: const BottomActionsWidget()),
              ],
            );
        }
      },
    );
  }
}