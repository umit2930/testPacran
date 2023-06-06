import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class ConfirmCancelDialog extends StatelessWidget {
  const ConfirmCancelDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        width: 329.w,
        height: 242.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Image.asset(
              "assets/images/failed.png",
              height: 64.h,
              width: 64.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Text(
                "آیا از لغو ماموریت خود مطمین هستید؟",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: natural5),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 46.h),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context, false);
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
                    SizedBox(
                      width: 8.w,
                      height: 48.h,
                    ),
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
                            "لغو ماموریت",
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
