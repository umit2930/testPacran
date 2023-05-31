import 'package:dobareh_bloc/business_logic/auth/login/login_cubit.dart';
import 'package:dobareh_bloc/business_logic/auth/verify/verify_cubit.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';
import 'package:dobareh_bloc/presentation/auth/code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../components/custom_filled_button.dart';
import 'number_filed.dart';

class NumberPage extends StatelessWidget {
  const NumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) =>
              LoginCubit(authRepository: context.read<AuthRepository>()),
          child: const LoginForm(),
        ));
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();

    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
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
                    Container(
                      margin: EdgeInsets.only(top: 28.h),
                      width: 112.w,
                      height: 170.h,
                      child: Image.asset("assets/images/login.png"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 56.h),
                      child: Text("لطفا شماره همراه خود را وارد نمایید.",
                          style: textTheme.titleSmall),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.h, bottom: 5.h),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "شماره موبایل",
                          style: textTheme.bodySmall,
                        ),
                      ),
                    ),
                    NumberField(
                      textController: textController,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16.w, right: 16.w, bottom: 16.h, top: 8.h),
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (BuildContext context, LoginState state) {
                  switch (state.loginStatus) {
                    case LoginStatus.success:
                      var response = state.loginResponse!;
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Get.off(BlocProvider(
                          create: (context) => VerifyCubit(
                              authRepository: context.read<AuthRepository>(),
                              initNumber: response.mobile ?? "0",
                              initRemaining: response.remaining?.round() ?? 60),
                          child: const CodePage(),
                        ));
                      });
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
                  return SendButton(
                    buttonChild: const Text("ارسال کد"),
                    textEditingController: textController,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendButton extends StatefulWidget {
  const SendButton(
      {Key? key,
      required this.buttonChild,
      required this.textEditingController})
      : super(key: key);

  final Widget buttonChild;
  final TextEditingController textEditingController;

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  @override
  Widget build(BuildContext context) {
    //TODO write like code page timer setState
    Logger().e("button rebuild");

    widget.textEditingController.addListener(() {
      var controller = widget.textEditingController;
      if (controller.text == "0") {
        controller.text = "";
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      }
      setState(() {});
    });

    bool isEnable;
    isEnable = (widget.textEditingController.text.length > 9);

    return CustomFilledButton(
      onPressed: isEnable
          ? () {
              context
                  .read<LoginCubit>()
                  .login("0${widget.textEditingController.text}");
            }
          : null,
      // text: "ارسال کد",
      buttonChild: widget.buttonChild,
    );
  }
}
