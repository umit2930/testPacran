import 'package:dobareh_bloc/business_logic/auth/auth/authentication_cubit.dart';
import 'package:dobareh_bloc/business_logic/auth/login/login_cubit.dart';
import 'package:dobareh_bloc/business_logic/auth/verify/timer_cubit.dart';
import 'package:dobareh_bloc/business_logic/auth/verify/verify_cubit.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';
import 'package:dobareh_bloc/presentation/auth/number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/colors.dart';
import '../components/custom_filled_button.dart';

class CodePage extends StatelessWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger().e("verify page build");
    return BlocProvider(
      create: (context) =>
          LoginCubit(authRepository: context.read<AuthRepository>()),
      child: const VerifyForm(),
    );
  }
}

class VerifyForm extends StatelessWidget {
  const VerifyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    TextEditingController pinController = TextEditingController();


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                                    text: context.read<VerifyCubit>().state.initNumber,
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
                              Get.offAll(NumberPage());
                            },
                            child: const Text("تغییر شماره")),
                      ),

                      ///Pin code
                      Padding(
                        padding: EdgeInsets.only(top: 43.h),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                              controller: pinController,
                              /*  onCompleted: (String value) {
                                loginViewModel.setCode(value);
                              },*/
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
                                fieldOuterPadding: EdgeInsets.all(5.h),
                              ),
                              appContext: context,
                              length: 5,
                              onChanged: (value) {}),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  switch (state.loginStatus) {
                    case LoginStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case LoginStatus.failure:
                      WidgetsBinding.instance.addPostFrameCallback((_) =>
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text(state.loginMessage.toString()))));
                    default:
                      break;
                  }
                  return RemainingTimerWidget();
                },
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, bottom: 16.h, top: 16.h),

                child: BlocBuilder<VerifyCubit, VerifyState>(
                  builder: (BuildContext context, VerifyState state) {
                    Logger().e("verify bloc build");
                    switch (state.verifyStatus) {
                      case VerifyStatus.success:
                        // AuthenticationCubit control the app flow and goes to the home page.
                        WidgetsBinding.instance.addPostFrameCallback((_) =>
                            context.read<AuthenticationCubit>().userChanged());

                      case VerifyStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                      case VerifyStatus.failure:
                        WidgetsBinding.instance.addPostFrameCallback((_) =>
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  content: Text(state.errorMessage.toString()))));

                      default:
                        break;
                    }
                    return SendButton(
                        buttonChild:  const Text("ارسال کد"),
                        textEditingController: pinController,
                        onPressed: () {
                          context
                              .read<VerifyCubit>()
                              .verify(context.read<VerifyCubit>().state.initNumber, pinController.text);
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RemainingTimerWidget extends StatelessWidget {
  const RemainingTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerCubit timerCubit = TimerCubit();
    var textTheme = Theme.of(context).textTheme;
    return BlocBuilder<TimerCubit, TimerState>(
        bloc: timerCubit,
        builder: (context, state) {
          switch (state.timerStatus) {
            case TimerStatus.initial:
              timerCubit.startTimer(
                  ((context.read<LoginCubit>().state.loginResponse?.remaining?.round()) ??
                      context.read<VerifyCubit>().state.initRemaining));
              return const Center();
              break;
            case TimerStatus.inProgress:
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    //TODO add dynamic time
                    Text(
                      " کدی دریافت نشد؟ ${state.tiks}ثانیه تا ارسال مجدد ",
                      style: textTheme.bodyMedium?.copyWith(color: natural5),
                    )
                  ],
                ),
              );
              break;
            case TimerStatus.complete:
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      "کدی دریافت نشد؟",
                      style: textTheme.bodyMedium?.copyWith(color: natural5),
                    ),
                    TextButton(
                        onPressed: () {
                          context
                              .read<LoginCubit>()
                              .login(context.read<VerifyCubit>().state.initNumber);
                        },
                        child: const Text("ارسال مجدد")),
                  ],
                ),
              );
              break;
          }
        });
  }
}

class SendButton extends StatefulWidget {
  const SendButton(
      {Key? key,
      required this.buttonChild,
      required this.textEditingController,
      required this.onPressed})
      : super(key: key);

  final Widget buttonChild;
  final TextEditingController textEditingController;
  final Function() onPressed;

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.textEditingController.addListener(() {
        Logger().w("changed => ${widget.textEditingController.text}");
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //TODO write like code page timer setState

    bool isEnable;
    isEnable = (widget.textEditingController.text.length > 4);

    Logger().e("code rebuild. text => ${widget.textEditingController.text}");

    return CustomFilledButton(
      onPressed: isEnable ? widget.onPressed : null,
      buttonChild: widget.buttonChild,
    );
  }
}
