import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFilledButton extends StatelessWidget {
  CustomFilledButton(
      {Key? key, required this.onPressed, required this.buttonChild,this.width})
      : super(key: key);

  Function()? onPressed;
  Widget buttonChild;
  double? width;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      height: 56.h,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.secondary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r))),
        child: buttonChild,
      ),
    );
  }
}
