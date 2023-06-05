import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/login/login_cubit.dart';
import '../../../business_logic/timer/timer_cubit.dart';
import '../../../business_logic/verify/verify_cubit.dart';
import '../../../utils/colors.dart';
import '../general/loading_widget.dart';

class RemainingTimerWidget extends StatelessWidget {
  const RemainingTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late TimerCubit timerCubit;

    var textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          timerCubit = TimerCubit();
          switch (state.loginStatus) {
            case LoginStatus.loading:
              return const Center(child: LoadingWidget());
            case LoginStatus.failure:
              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  context.showToast(
                      message: state.errorMessage.toString(),
                      messageType: MessageType.error));
            default:
              break;
          }
          return BlocBuilder<TimerCubit, TimerState>(
              bloc: timerCubit,
              builder: (context, state) {
                switch (state.timerStatus) {
                  case TimerStatus.initial:
                    timerCubit.startTimer(((context
                            .read<LoginCubit>()
                            .state
                            .loginResponse
                            ?.remaining
                            ?.round()) ??
                        context.read<VerifyCubit>().state.initRemaining));
                    return const Center();
                  case TimerStatus.inProgress:
                    return Row(
                      children: [
                        Text(
                          " کدی دریافت نشد؟ ${state.tiks}ثانیه تا ارسال مجدد ",
                          style:
                              textTheme.bodyMedium?.copyWith(color: natural5),
                        )
                      ],
                    );
                  case TimerStatus.complete:
                    return Row(children: [
                      Text(
                        "کدی دریافت نشد؟",
                        style: textTheme.bodyMedium?.copyWith(color: natural5),
                      ),
                      TextButton(
                          onPressed: () {
                            context.read<LoginCubit>().loginSubmitted(
                                context.read<VerifyCubit>().state.initNumber);
                          },
                          child: const Text("ارسال مجدد"))
                    ]);
                }
              });
        },
      ),
    );
  }
}
