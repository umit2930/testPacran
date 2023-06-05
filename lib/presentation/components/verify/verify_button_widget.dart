import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/verify/verify_cubit.dart';
import '../general/custom_filled_button.dart';
import '../general/loading_widget.dart';

class VerifyButtonWidget extends StatelessWidget {
  const VerifyButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyCubit, VerifyState>(
      builder: (BuildContext context, VerifyState state) {
        var isEnable = context.read<VerifyCubit>().state.code.length == 5;

        return (state.verifyStatus == VerifyStatus.loading)
            ? const Center(child: LoadingWidget())
            : CustomFilledButton(
                onPressed: isEnable
                    ? () {
                        context.read<VerifyCubit>().verifySubmitted(
                              context.read<VerifyCubit>().state.initNumber,
                              context.read<VerifyCubit>().state.code,
                            );
                      }
                    : null,
                buttonChild: const Text("ارسال کد"));
      },
    );
  }
}
