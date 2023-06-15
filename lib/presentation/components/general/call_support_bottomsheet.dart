import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/colors.dart';
import 'custom_filled_button.dart';

class CallSupportBottomsheet extends StatelessWidget {
  const CallSupportBottomsheet({Key? key, required this.number})
      : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 16.w),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: Wrap(
        children: [
          Text(
            "تماس با پشتیبانی",
            style: textTheme.bodyMedium?.copyWith(color: natural2),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomFilledButton(
                  width: 156.w,
                  onPressed: () async {
                    Uri phoneNo = Uri.parse('tel:$number');
                    launchUrl(phoneNo);
                  },
                  buttonChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/call.svg", color: white),
                      const Text(" گرفتن تماس")
                    ],
                  ),
                ),
                Text(
                  number,
                  style: textTheme.bodyMedium?.copyWith(color: natural2),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
