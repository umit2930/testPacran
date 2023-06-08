import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';

class FailedDialog extends StatelessWidget {
  const FailedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        width: 329.w,
        height: 322.h,
        child: Column(
          children: [
            Image.asset(
              "assets/images/failed.png",
              height: 64.h,
              width: 64.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 35.h),
              child: Text(
                "ثبت فاکتور با مشکل مواجه شد",
                style: textTheme.titleSmall?.copyWith(color: error),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 35.h),
              child: Text(
                "ثبت مقادیر با مشکل مواجه شد، لطفا دوباره اقدام کنید.",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: natural5),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 35.h, left: 18.w, right: 18.w),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                              backgroundColor: secondaryTint2),
                          onPressed: () {},
                          child: Text(
                            "تلاش مجدد",
                            style: textTheme.bodyMedium
                                ?.copyWith(color: secondary),
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
                        height: 48.h,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: secondaryTint2),
                          ),
                          child: Text(
                            "تماس با پشتیبانی",
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
