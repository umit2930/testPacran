import 'package:dobareh_bloc/business_logic/auth/auth/authentication_cubit.dart';
import 'package:dobareh_bloc/business_logic/auth/login/login_cubit.dart';
import 'package:dobareh_bloc/business_logic/auth/verify/timer_cubit.dart';
import 'package:dobareh_bloc/business_logic/auth/verify/verify_cubit.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';
import 'package:dobareh_bloc/presentation/auth/number_page.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/colors.dart';
import '../components/custom_filled_button.dart';
import '../components/loading_widget.dart';

class CodePage extends StatelessWidget {
  const CodePage({Key? key}) : super(key: key);

  static Widget router(
      {required String initNumber, required int initRemaining}) {
    return BlocProvider(
      create: (context) => VerifyCubit(
          authRepository: context.read<AuthRepository>(),
          initNumber: initNumber,
          initRemaining: initRemaining),
      child: const CodePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: VerifyForm());
  }
}

class VerifyForm extends StatelessWidget {
  const VerifyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return BlocListener<VerifyCubit, VerifyState>(
      listenWhen: (oldStatus, newStatus) {
        return oldStatus.verifyStatus != newStatus.verifyStatus;
      },
      listener: (context, state) {
        if (state.verifyStatus == VerifyStatus.failure) {
          context.showToast(
              message: state.errorMessage.toString(),
              messageType: MessageType.error);
        } else if (state.verifyStatus == VerifyStatus.success) {
          ///AuthenticationCubit will do the navigation process.
          context.read<AuthenticationCubit>().userChanged();
        }
      },
      child: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///Appbar
              Container(
                height: 66.h,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          // Get.off(NumberPage());
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/arrow_right.svg",
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          "وارد کردن کد فعالسازی",
                          style: textTheme.bodyMedium?.copyWith(
                              color: natural1, fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 72.h),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: textTheme.bodyLarge?.copyWith(
                                    color:
                                        const Color.fromRGBO(120, 117, 121, 1)),
                                children: [
                                  const TextSpan(
                                      text: "لطفا کد فعالسازی که برای "),
                                  TextSpan(
                                      text: context
                                          .read<VerifyCubit>()
                                          .state
                                          .initNumber,
                                      style: textTheme.bodyLarge),
                                  const TextSpan(
                                      text: "\n پیامک شده است را وارد نمایید."),
                                ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: TextButton(
                              onPressed: () {
                                Get.offAll(NumberPage.router());
                              },
                              child: const Text("تغییر شماره")),
                        ),

                        ///Pin code
                        Padding(
                            padding: EdgeInsets.only(top: 43.h),
                            child: const PinCodeWidget())
                      ]),
                ),
              ),

              ///Timer
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const RemainingTimerWidget()),

              ///Verify button
              Padding(
                  padding: EdgeInsets.only(
                      left: 16.w, right: 16.w, bottom: 16.h, top: 16.h),
                  child: const VerifyButton())
            ],
          ),
        ),
      ),
    );
  }
}

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

class RemainingTimerWidget extends StatelessWidget {
  const RemainingTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late TimerCubit timerCubit;

    var textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) =>
          LoginCubit(authRepository: context.read<AuthRepository>()),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          timerCubit = TimerCubit();
          switch (state.loginStatus) {
            case LoginStatus.loading:
              return const Center(child: LoadingWidget());
            case LoginStatus.failure:
              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text(state.errorMessage.toString()))));
/*          case LoginStatus.success:
            timerCubit.startTimer(((context
                    .read<LoginCubit>()
                    .state
                    .loginResponse
                    ?.remaining
                    ?.round()) ??
                context.read<VerifyCubit>().state.initRemaining));
            break;*/
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
                        //TODO add dynamic time
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
                            context.read<LoginCubit>().login(
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

class VerifyButton extends StatelessWidget {
  const VerifyButton({Key? key}) : super(key: key);

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
                        context.read<VerifyCubit>().verify(
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
