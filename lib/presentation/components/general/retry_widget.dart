import 'package:dobareh_bloc/presentation/components/general/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget(
      {Key? key, required this.onRetryPressed, this.errorMessage})
      : super(key: key);

  final Function() onRetryPressed;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Lottie.asset("assets/anim/failure.json",
            repeat: false, width: 100.r, height: 250.r),
        Text(errorMessage ?? "مشکلی روی داده است."),
        Padding(
          padding: EdgeInsets.only(top: 32.h),
          child: CustomFilledButton(
              onPressed: onRetryPressed, buttonChild: const Text("تلاش مجدد")),
        )
      ]),
    );
  }
}
