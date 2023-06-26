import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
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
    return SizedBox(
      height: 56.h,
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: secondary),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r))),
        child: buttonChild,
      ),
    );
  }
}
