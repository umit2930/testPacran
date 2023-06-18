import 'package:dobareh_bloc/business_logic/order/order_details_cubit.dart';
import 'package:dobareh_bloc/presentation/components/general/location_checker.dart';
import 'package:dobareh_bloc/presentation/components/order_details/open_street_map_widget.dart';
import 'package:dobareh_bloc/utils/icon_assistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../data/model/order/order_response.dart';
import '../../utils/colors.dart';
import '../components/general/loading_widget.dart';
import '../components/general/retry_widget.dart';
import '../components/order_details/material_item.dart';
import 'order_datails_page.dart';

class DeliveredOrderDetailsPage extends StatelessWidget {
  const DeliveredOrderDetailsPage({Key? key}) : super(key: key);

  static Widget router({required int orderID}) {
    return BlocProvider(
      create: (context) => OrderDetailsCubit(orderID: orderID),
      child: const DeliveredOrderDetailsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: const OrderDetailsBody(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(66.h),
            child: const DeliveredOrderAppbar()));
  }
}

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;
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
              var materials = state.orderResponse?.order?.materialCategories
                  ?.where(
                      (element) {
                        // Logger().e(element.pivot?.finalValue != "0");
                    return element.pivot?.finalValue != "0";
                  }
              );

              Logger().w(materials);

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ///Code
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: background),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "کد سفارش",
                                  style: textTheme.bodyMedium
                                      ?.copyWith(color: natural4),
                                ),
                                Text(
                                  order?.trackingCode ?? "نامشخص",
                                  style: textTheme.titleSmall
                                      ?.copyWith(color: natural2),
                                )
                              ],
                            ),
                          ),

                          ///Date
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: background),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      "تاریخ ثبت فروشنده",
                                      style: textTheme.bodyMedium
                                          ?.copyWith(color: natural4),
                                    ),
                                    Text(
                                      getCreatedDateTime(order ?? Order()),
                                      style: textTheme.bodyMedium
                                          ?.copyWith(color: natural2),
                                    )
                                  ],
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(top:10.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        "تاریخ دریافتی",
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: natural4),
                                      ),
                                      Text(
                                        getDeliveredDateTime(order ?? Order()),
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: natural2),
                                      )
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(top:10.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        "تاریخ تحویل به انبار",
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: natural4),
                                      ),
                                      Text(
                                        "چهارشنبه ۲۲ دی-۱۱:۲۰",
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: natural2),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 16.h),
                            decoration: boxDecoration,
                            child: Column(
                              children: [

                                ///User data
                                Container(
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
                                              order?.deliveryPersonName ??
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
                                                  right: 8.w,
                                                  left: 8.w,
                                                  top: 4.h),
                                              child: SvgPicture.asset(
                                                  "assets/icons/location.svg"),
                                            ),
                                            Expanded(
                                              child: Text(
                                                order?.address?.address ??
                                                    "آدرس",
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

                                ///Map
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 172.h,
                                      child: LocationCheckerWidget(
                                        mapWidget: OpenStreetWidget(
                                          order: order ?? Order(),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),

                          ///Weight of items
                          Padding(
                            padding: EdgeInsets.only(top: 24.h),
                            child: Text(
                              "موارد بازیافتی ثبت شده توسط شما",
                              style:
                              textTheme.bodyMedium?.copyWith(color: natural1),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18.h, bottom: 64.h),
                            decoration: BoxDecoration(
                                color: natural8,
                                borderRadius: BorderRadius.circular(12.r)),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                var item = materials?.elementAt(index);
                                return MaterialItem(
                                  title: item?.title ?? "عنوان",
                                  unit: "کیلو"
                                  /*item.unit*/
                                  ,
                                  weight: item?.pivot?.finalValue ?? "0",
                                );
                              },
                              itemCount: materials?.length ?? 0,
                            ),
                          ),

                          /*          ///messages
                      Container(
                          margin: EdgeInsets.only(top: 66.h, bottom: 10.h),
                          decoration: BoxDecoration(
                              color: natural8,
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icons/comment.svg"),
                                  Text("مشاهده پیام ها")
                                ],
                              ),
                            ),
                          )),*/
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
        });
  }

  String getCreatedDateTime(Order order) {
    String dateTime = "";
    dateTime += order.persianCreatedAt?.persianDayOfWeek ?? "";
    dateTime += order.persianCreatedAt?.dayOfMonthInJalali ?? "";
    dateTime += order.persianCreatedAt?.persianMonth ?? "";
    dateTime += "-";
    dateTime += order.persianCreatedAt?.time?.substring(0, 5) ?? "";
    return dateTime;
  }

  String getDeliveredDateTime(Order order) {
    String dateTime = "";
    dateTime += order.persianDelivered?.persianDayOfWeek ?? "";
    dateTime += order.persianDelivered?.dayOfMonthInJalali ?? "";
    dateTime += order.persianDelivered?.persianMonth ?? "";
    dateTime += "-";
    dateTime += order.persianDelivered?.time?.substring(0, 5) ?? "";
    return dateTime;
  }
}

class DeliveredOrderAppbar extends StatelessWidget {
  const DeliveredOrderAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAssistant.backIconButton(() => Get.back()),
            Expanded(
              child: Text("جزئیات سفارش",
                  style: textTheme.bodySmall?.copyWith(color: secondary)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text("تحویل گرفته شده",
                  style: textTheme.labelLarge?.copyWith(color: primary)),
            ),
            PopupMenuButton<MenuItem>(
              onSelected: (MenuItem selected) {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              itemBuilder: (BuildContext context) {
                return [
                  /*PopupMenuItem(
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
*/
                ];
              },
              child: SvgPicture.asset(
                "assets/icons/more.svg",
                height: 46.h,
                width: 46.w,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
