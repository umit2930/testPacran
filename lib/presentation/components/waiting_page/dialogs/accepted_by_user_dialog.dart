import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../pages/home_page.dart';
import '../../general/custom_filled_button.dart';

class AcceptedByUserDialog extends StatelessWidget {
  const AcceptedByUserDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      child: Container(
        alignment: Alignment.center,
        width: 329.w,
        height: 247.h,
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Image.asset(
              "assets/images/success.png",
              height: 64.h,
              width: 64.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 35.h),
              child: Text(
                "مقادیر پسماند توسط کاربر تایید شد",
                style: textTheme.titleSmall?.copyWith(color: natural2),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 35.h),
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
