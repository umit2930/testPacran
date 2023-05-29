import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class NumberField extends StatelessWidget {
  NumberField({Key? key, required this.textController}) : super(key: key);

  TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
        height: 48.h,
        child: TextFormField(
          maxLength: 10,
          keyboardType: TextInputType.phone,
          controller: textController,
          textDirection: TextDirection.ltr,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(isDense: true,
              counterText: "",contentPadding: EdgeInsets.zero,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: primary)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: natural7)),
              suffixIcon: Container(
                  margin: EdgeInsets.only(top:1.h,left: 1.w,bottom: 1.h,right: 16.w),
                  decoration: BoxDecoration(
                      color: primaryTint3,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(12.r))),
                  alignment: Alignment.center,
                  width: 57.w,
                  height: 45.h,
                  child: const Text("۹۸+"))),
        ));
  }
}
