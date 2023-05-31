import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: OverflowBox(
        minHeight: 125.h,
        maxHeight: 125.w,
        child:  Lottie.asset("assets/anim/truck_loading.json",fit: BoxFit.cover),
      ),
    );
  }
}
