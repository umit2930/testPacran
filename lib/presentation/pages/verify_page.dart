import 'package:dobareh_bloc/utils/extension.dart';
import 'package:dobareh_bloc/utils/icon_assistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../business_logic/auth/authentication_cubit.dart';
import '../../business_logic/verify/verify_cubit.dart';
import '../../utils/colors.dart';
import '../components/verify/pin_code_widget.dart';
import '../components/verify/remaining_timer_widget.dart';
import '../components/verify/verify_button_widget.dart';
import 'number_page.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({Key? key}) : super(key: key);

  static Widget router(
      {required String initNumber, required int initRemaining}) {
    return BlocProvider(
      create: (context) =>
          VerifyCubit(initNumber: initNumber, initRemaining: initRemaining),
      child: const VerifyPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const VerifyAppBar(),
      ),
      body: const VerifyBody(),
    );
  }
}

class VerifyAppBar extends StatelessWidget {
  const VerifyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        height: 66.h,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Stack(alignment: Alignment.center, children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconAssistant.backIconButton(
              () => Get.off(NumberPage.router()),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "وارد کردن کد فعالسازی",
              style: textTheme.bodyMedium
                  ?.copyWith(color: natural1, fontWeight: FontWeight.w400),
            ),
          ),
        ]),
      ),
    );
  }
}

class VerifyBody extends StatelessWidget {
  const VerifyBody({Key? key}) : super(key: key);

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
          context.read<AuthenticationCubit>().authRequested();
        }
      },
      child: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              RepaintBoundary(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const RemainingTimerWidget()),
              ),

              ///Verify button
              Padding(
                  padding: EdgeInsets.only(
                      left: 16.w, right: 16.w, bottom: 16.h, top: 16.h),
                  child: const VerifyButtonWidget())
            ],
          ),
        ),
      ),
    );
  }
}
