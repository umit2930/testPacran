import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../business_logic/orders_list/orders_list_cubit.dart';
import '../../../data/model/order/orders_list_response.dart';
import '../../../utils/colors.dart';

class WarehouseTab extends StatefulWidget {
  WarehouseTab({Key? key}) : super(key: key);

  @override
  State<WarehouseTab> createState() => _WarehouseTabState();
}

class _WarehouseTabState extends State<WarehouseTab> {
  // var homeViewmodel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w,bottom: 16.h),
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
                            context.read<OrdersListCubit>().state.selectedDate.formatCompactDate(),
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
                child: Container(
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
                ),
              ),
            ),
          ],
        ));
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
