import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/enums.dart';

class DeliveredItem extends StatelessWidget {
  const DeliveredItem(
      {Key? key,
      required this.personName,
      required this.address,
      required this.orderStatus,
      required this.dateTime,
      this.onPressed,
      this.backgroundColor})
      : super(key: key);

  final String personName;

  final String address;

  final Function()? onPressed;
  final Color? backgroundColor;

  final OrderStatus orderStatus;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: 16.h),
      decoration: backgroundColor == null
          ? boxDecoration
          : BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12.r)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: SvgPicture.asset("assets/icons/person.svg"),
                    ),
                    Expanded(
                      child: Text(personName,
                          style: textTheme.bodyMedium?.copyWith(color: natural3)),
                    ),
                    // if (orderStatus.value == OrderStatus.delivered.value) ...[
                    Text("تحویل گرفته شده",
                        style: textTheme.labelLarge?.copyWith(color: primary))
                    // ] else if (orderStatus.value ==
                    //     OrderStatus.rejected.value) ...[
                    //   Text("لغو شده",
                    //       style: textTheme.bodyMedium?.copyWith(color: primary))
                    // ]
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                            top: 8.h,
                            left: 8.w,
                          ),
                          child: SvgPicture.asset("assets/icons/location.svg")),
                      Expanded(
                        child: Text(address,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium
                                ?.copyWith(color: natural1)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 2.w),
                          child: SvgPicture.asset("assets/icons/calendar.svg")),
                      Expanded(
                        child: Row(
                          children: [
                            Text(" دریافتی: ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: natural4)),
                            Text(dateTime,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: natural1)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
