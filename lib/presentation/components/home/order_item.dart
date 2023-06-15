import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';

class HomeOrderItem extends StatelessWidget {
  const HomeOrderItem(
      {Key? key,
      required this.personName,
      required this.address,
      required this.isActive,
      this.onPressed,
      this.backgroundColor})
      : super(key: key);

  final String personName;

  final String address;

  final Function()? onPressed;
  final Color? backgroundColor;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      // height: 100.h,
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
                    SvgPicture.asset("assets/icons/person.svg"),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Text(personName,
                            style: textTheme.bodyMedium
                                ?.copyWith(color: natural3)),
                      ),
                    ),
                    if (isActive) ...[
                      SvgPicture.asset(
                        "assets/icons/active.svg",
                        height: 24,
                        width: 24,
                        fit: BoxFit.fill,
                      ),
                    ]
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 4.0, left: 2.w),
                          child: SvgPicture.asset("assets/icons/location.svg")),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Text(address,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: natural1)),
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
