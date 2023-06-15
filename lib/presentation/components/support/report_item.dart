import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/model/report/ReportResponse.dart';
import '../../../utils/colors.dart';

class ReportItem extends StatelessWidget {
  const ReportItem({Key? key, required this.onTap, required this.report})
      : super(key: key);

  final Function() onTap;
  final Report report;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(12.r)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Text(
                          report.question ?? "مشکل ",
                          style: textTheme.bodyMedium?.copyWith(color: natural2),
                        ),
                      ),
                    ),
                    SvgPicture.asset("assets/icons/arrow_left.svg")
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
