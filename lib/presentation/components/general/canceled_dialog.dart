import 'package:dobareh_bloc/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import 'custom_filled_button.dart';

class CanceledDialog extends StatelessWidget {
  const CanceledDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(top: 10.h),
        alignment: Alignment.center,
        width: 329.w,
        height: 283.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/success.png",
              height: 64.h,
              width: 64.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: Text(
                "ماموریت لغو شد",
                style: textTheme.titleSmall?.copyWith(color: natural2),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Text(
                "در صورت نیاز با پشتیبانی تماس بگیرید",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: natural5),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: CustomFilledButton(
                    width: 156.w,
                    onPressed: () {
                      Get.offAll(HomePage.router());
                    },
                    buttonChild: const Text("تایید")))
          ],
        ),
      ),
    );
  }
}
