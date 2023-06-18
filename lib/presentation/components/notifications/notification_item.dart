import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/notification_router.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem(
      {Key? key,
      required this.title,
      required this.body,
      required this.createdAt,
      required this.location})
      : super(key: key);

  final String title;
  final String body;
  final String createdAt;
  final String location;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(12.r)),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/red_dot.svg", fit: BoxFit.fill),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Text(
                    title,
                    style: textTheme.bodyMedium?.copyWith(color: natural2),
                  ),
                ),
              ),
              Text(
                createdAt,
                style: textTheme.bodySmall?.copyWith(color: natural6),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              body,
              style: textTheme.bodyMedium?.copyWith(color: natural4),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                notificationRouter(location);
              },
              child: Text(
                "مشاهده",
                style: textTheme.bodyMedium?.copyWith(color: secondary),
              ),
            ),
          )
        ],
      ),
    );
  }
}
