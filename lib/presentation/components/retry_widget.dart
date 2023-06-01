import 'package:dobareh_bloc/presentation/components/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

Widget getFailureWidget(
    {required Function() onRetryPressed, String? errorMessage}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/anim/failure.json", repeat: false),
        Text(errorMessage ?? "مشکلی روی داده است."),
        Padding(
          padding: EdgeInsets.only(top: 32.h),
          child: CustomFilledButton(
              onPressed: onRetryPressed, buttonChild: const Text("تلاش مجدد")),
        )
      ],
    ),
  );
}
