import 'package:dobareh_bloc/business_logic/orders_list/orders_list_cubit.dart';
import 'package:dobareh_bloc/presentation/pages/order_datails_page.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/enums.dart';
import '../general/loading_widget.dart';
import '../general/retry_widget.dart';
import '../home/order_item.dart';

class WaitingTab extends StatelessWidget {
  const WaitingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return BlocBuilder<OrdersListCubit, OrdersListState>(
        builder: (context, state) {
      switch (state.waitingOrdersStatus) {
        case WaitingOrdersStatus.initial:
          context.read<OrdersListCubit>().waitingOrdersRequested();
          return const LoadingWidget();
        case WaitingOrdersStatus.loading:
          return const LoadingWidget();
        case WaitingOrdersStatus.failure:
          return FailureWidget(
            onRetryPressed: () {
              context.read<OrdersListCubit>().waitingOrdersRequested();
            },
            errorMessage: state.errorMessage,
          );
        case WaitingOrdersStatus.success:
          return const WaitingTabSuccessWidget();
      }
    });
  }
}

class WaitingTabSuccessWidget extends StatelessWidget {
  const WaitingTabSuccessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return BlocBuilder<OrdersListCubit, OrdersListState>(
        buildWhen: (pState, nState) {
      return pState.selectedTimePackID != nState.selectedTimePackID;
    }, builder: (context, state) {
      var selectedTimeID = state.selectedTimePackID;

      var selectedTime = state.waitingPacks!.keys.elementAt(selectedTimeID);

      var selectedTimePack =
          state.waitingPacks!.values.elementAt(selectedTimeID);

      var filteredTimePack = selectedTimePack
          .where((element) => element.status == OrderStatus.waiting.value);
      return SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 16.h, left: 16.w, right: 16.w, bottom: 16.h),
              child: Row(
                children: [
                  const Expanded(child: Text("لیست جمع آوری‌های در انتظار")),
                  SizedBox(
                    // width: 106.w,
                    child: PopupMenuButton<int>(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      onSelected: (item) {
                        context
                            .read<OrdersListCubit>()
                            .timePackSelected(index: item);
                      },
                      itemBuilder: (BuildContext context) {
                        return List<PopupMenuItem<int>>.generate(
                            state.waitingPacks!.keys.length, (index) {
                          var selectedTime =
                              state.waitingPacks!.keys.elementAt(index);
                          return PopupMenuItem(
                              value: index,
                              child: Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context)
                                        .copyWith(disabledColor: primary),
                                    child: Checkbox(
                                      value: selectedTimeID == index,
                                      onChanged: null,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Text(
                                      "${selectedTime.from} تا  ${selectedTime.to}",
                                      style: textTheme.titleSmall
                                          ?.copyWith(color: natural1),
                                    ),
                                  ),
                                ],
                              ));
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        // width: 106.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: background,
                            border: Border.all(color: secondaryTint2),
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(right: 8.w),
                                child: Text(
                                    "${selectedTime.from} تا  ${selectedTime.to}",
                                    style: textTheme.titleSmall
                                        ?.copyWith(color: natural1)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8.w,left: 8.w),
                                child: SvgPicture.asset(
                                    "assets/icons/arrow_down.svg"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  if (filteredTimePack.isNotEmpty) ...[
                    ListView.builder(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 80.h),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var item = filteredTimePack.elementAt(index);

                        return HomeOrderItem(
                            isActive: false,
                            personName: item.deliveryPersonName!,
                            address: item.address!.address!,
                            onPressed: state.inProgressOrder == null
                                ? () {
                                    Get.to(OrderDetailsPage.router(
                                        orderID: item.id!.toInt()));
                                  }
                                : () {
                                    context.showToast(
                                        message:
                                            "شما یک سفارش در حال پردازش دارید!",
                                        messageType: MessageType.warning);
                                  });
                      },
                      itemCount: selectedTimePack
                          .where((element) =>
                              element.status == OrderStatus.waiting.value)
                          .length,
                    ),
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
            ))
          ],
        ),
      );
      ;
    });
  }
}
