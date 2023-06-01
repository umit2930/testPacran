import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton(
      {Key? key,
      required this.onPressed,
      required this.buttonChild,
      this.width})
      : super(key: key);

  final Function()? onPressed;
  final Widget buttonChild;
  final double? width;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      // height: 56.h,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.secondary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r))),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: buttonChild,
        ),
      ),
    );
  }
}
