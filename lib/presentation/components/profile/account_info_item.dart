import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class AccountInfoItem extends StatelessWidget {
  const AccountInfoItem(
      {Key? key, required this.title, required this.value, required this.onTap})
      : super(key: key);

  final String title;
  final String value;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(vertical: 8.w),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(12.r)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(

          ///uncommit for working
          // onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(color: natural4),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(value == "null" ? "وارد نشده" : value,
                          textAlign: TextAlign.left,
                          style: textTheme.bodyMedium?.copyWith(
                            color: natural2,
                          )),
                    ),
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
