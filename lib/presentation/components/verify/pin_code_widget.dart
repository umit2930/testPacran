import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../business_logic/verify/verify_cubit.dart';
import '../../../utils/colors.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeTextField(
            onChanged: (value) {
              context.read<VerifyCubit>().codeChanged(value);
            },
            textStyle: textTheme.bodyLarge,
            keyboardType: TextInputType.number,
            mainAxisAlignment: MainAxisAlignment.center,
            enableActiveFill: true,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                fieldHeight: 58.h,
                fieldWidth: 58.h,
                borderWidth: 1,
                activeFillColor: natural8.withOpacity(0.4),
                selectedFillColor: natural8.withOpacity(0.4),
                inactiveFillColor: natural8.withOpacity(0.4),
                activeColor: primary,
                inactiveColor: natural7,
                selectedColor: secondary,
                fieldOuterPadding: EdgeInsets.all(5.h)),
            appContext: context,
            length: 5));
  }
}
