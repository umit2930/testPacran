import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';
import '../../general/confirm_cancel_dialog.dart';

class CalculateAgainDialog extends StatelessWidget {
  const CalculateAgainDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        width: 329.w,
        height: 322.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Image.asset(
              "assets/images/failed.png",
              height: 64.h,
              width: 64.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                "محاسبه دوباره",
                style: textTheme.titleSmall?.copyWith(color: error),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Text(
                "فروشنده درخواست محاسبه دوباره داده‌است، برای ثبت مقادیر درست مجددا وزن‌کشی کنید و مقادیر جدید را ثبت کنید",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: natural5),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 35.h),
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
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text(
                            "محاسبه دوباره",
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
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return ConfirmCancelDialog();
                                }).then((value) {
                              if (value == true) {
                                Navigator.pop(context, false);
                              }
                            });
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
