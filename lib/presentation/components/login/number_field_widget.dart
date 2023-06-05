import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';
import '../../../business_logic/login/login_cubit.dart';

class NumberFieldWidget extends StatelessWidget {
  const NumberFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var controller = TextEditingController();

    ///prevent inserting zero
    controller.addListener(() {
      if (controller.text == "0") {
        controller.text = "";
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      }
    });
    return SizedBox(
        height: 48.h,
        child: TextFormField(
          maxLength: 10,
          keyboardType: TextInputType.phone,
          onChanged: (newValue) {
            context.read<LoginCubit>().numberChanged(newValue);
          },
          controller: controller,
          textDirection: TextDirection.ltr,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
              isDense: true,
              counterText: "",
              contentPadding: EdgeInsets.zero,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: primary)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: natural7)),
              suffixIcon: Container(
                  margin: EdgeInsets.only(
                      top: 1.h, left: 1.w, bottom: 1.h, right: 16.w),
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
