import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class AccountExitDialog extends StatelessWidget {
  const AccountExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        width: 329.w,
        height: 311.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/danger.svg",
              height: 32.h,
              width: 32.w,
            ),
            Container(
              margin: EdgeInsets.only(top: 22.h),
              decoration: BoxDecoration(
                  color: error.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12.r)),
              padding: EdgeInsets.only(
                  top: 26.h, bottom: 40.h, left: 16.w, right: 16.w),
              child: Text(
                "از خارج شدن حساب کاربری خود مطمین هستید؟",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: textTheme.bodyMedium?.copyWith(color: natural2),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 35.h),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 56.h,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                              backgroundColor: secondary),
                          onPressed: () {
                            Get.back(result: true);
                          },
                          child: Text(
                            "خروج",
                            style: textTheme.bodyMedium?.copyWith(color: white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                      height: 48.h,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 56.h,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.back(result: false);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: secondaryTint2),
                          ),
                          child: Text(
                            "انصراف",
                            style: textTheme.bodyMedium
                                ?.copyWith(color: secondary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
