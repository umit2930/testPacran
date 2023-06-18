import 'package:dobareh_bloc/business_logic/orders_list/orders_list_cubit.dart';
import 'package:dobareh_bloc/presentation/pages/delivered_order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../data/model/order/orders_list_response.dart';
import '../../../utils/colors.dart';
import '../../../utils/enums.dart';
import '../general/loading_widget.dart';
import '../general/retry_widget.dart';
import 'delivered_item.dart';

class DeliveredTab extends StatelessWidget {
  const DeliveredTab({Key? key}) : super(key: key);

  // var homeViewmodel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: BlocBuilder<OrdersListCubit, OrdersListState>(
          buildWhen: (pState, nState) {
            return pState.selectedDate.toString() ==
                nState.selectedDate.toString();
          },
          builder: (BuildContext context, state) {
            switch (state.deliveredOrdersStatus) {
              case DeliveredOrdersStatus.initial:
                context.read<OrdersListCubit>().deliveredOrdersRequested();
                return const LoadingWidget();
              case DeliveredOrdersStatus.loading:
                return const LoadingWidget();
              case DeliveredOrdersStatus.failure:
                return FailureWidget(
                  onRetryPressed: () {
                    context.read<OrdersListCubit>().deliveredOrdersRequested();
                  },
                  errorMessage: state.errorMessage,
                );
              case DeliveredOrdersStatus.success:
                return DeliveredTabSuccessWidget(state: state);
            }
          },
        ));
  }
}

class DeliveredTabSuccessWidget extends StatelessWidget {
  const DeliveredTabSuccessWidget({Key? key, required this.state})
      : super(key: key);

  final OrdersListState state;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return BlocBuilder<OrdersListCubit, OrdersListState>(
      builder: (context, state) {
        var deliveredOrders = state.deliveredOrders!;
        return SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 16.h, left: 16.w, right: 16.w, bottom: 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "لیست تحویل گرفته شده",
                        style: textTheme.bodyMedium?.copyWith(color: natural1),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          // padding: EdgeInsets.zero,
                          backgroundColor: background,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: secondaryTint2),
                              borderRadius: BorderRadius.circular(12.r))),
                      onPressed: () {
                        showPersianDatePicker(
                                context: context,
                                initialDate: Jalali.now(),
                                firstDate: Jalali(1402, 1),
                                lastDate: Jalali(1410, 1))
                            .then((value) {
                          context
                              .read<OrdersListCubit>()
                              .dateSelected(date: value ?? Jalali.now());
                          context
                              .read<OrdersListCubit>()
                              .deliveredOrdersRequested();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.selectedDate.formatCompactDate(),
                              style: textTheme.titleSmall
                                  ?.copyWith(color: natural1),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child:
                                  SvgPicture.asset("assets/icons/arrow_down.svg"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (deliveredOrders.isNotEmpty) ...[
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 64.h),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            var item = deliveredOrders.elementAt(index);
                            return DeliveredItem(
                              personName:
                                  item.deliveryPersonName ?? "نام تحویل گیرنده",
                              address: item.address?.address ?? "آدرس",
                              orderStatus:
                                  OrderStatus.fromString(item.status ?? ""),
                              dateTime: getDateTime(item),
                              onPressed: () {
                                Get.to(DeliveredOrderDetailsPage.router(orderID: item.id?.round() ?? 0));
                              },
                            );
                          },
                          itemCount: deliveredOrders.length,
                        )
                      ] else ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 60.h),
                          child: Column(children: [
                            SvgPicture.asset("assets/icons/empty.svg"),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h, bottom: 100.h),
                              child: Text(
                                "برای این بازه زمانی جمع آوری وجود ندارد",
                                style: textTheme.bodyLarge?.copyWith(
                                  color: natural6,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String getDateTime(Orders order) {
    String dateTime = "";
    dateTime += order.persianDateDetails?.persianDayOfWeek ?? "";
    dateTime += order.persianDateDetails?.dayOfMonthInJalali ?? "";
    dateTime += order.persianDateDetails?.persianMonth ?? "";
    dateTime += "-";
    dateTime += order.deliveredAt ?? "";
    return dateTime;
  }
}
