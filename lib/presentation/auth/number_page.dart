import 'package:dobareh_bloc/business_logic/auth/login/login_cubit.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';
import 'package:dobareh_bloc/presentation/auth/code_page.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../components/custom_filled_button.dart';
import '../components/loading_widget.dart';

class NumberPage extends StatelessWidget {
  const NumberPage({Key? key}) : super(key: key);

  static Widget router() {
    return BlocProvider(
      create: (context) =>
          LoginCubit(authRepository: context.read<AuthRepository>()),
      child: const NumberPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.white, body: LoginBody());
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    ///error handling
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (oldStatus, newStatus) {
        return oldStatus.loginStatus != newStatus.loginStatus;
      },
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.failure) {
          context.showToast(
              message: state.errorMessage, messageType: MessageType.error);
        } else if (state.loginStatus == LoginStatus.success) {
          var response = state.loginResponse!;
          // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Get.off(CodePage.router(
              initNumber: response.mobile ?? "0",
              initRemaining: response.remaining?.round() ?? 60));
          // });
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
                        padding: EdgeInsets.only(top: 15.h),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "شماره موبایل",
                            style: textTheme.bodySmall,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: const NumberField(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: 16.w, right: 16.w, bottom: 16.h, top: 8.h),
                  child: const LoginButton()),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberField extends StatelessWidget {
  const NumberField({Key? key}) : super(key: key);

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

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (BuildContext context, LoginState state) {
        return (state.loginStatus == LoginStatus.loading)
            ? const Center(child: LoadingWidget())
            : CustomFilledButton(
                onPressed: (state.number.length > 9)
                    ? () {
                        context.read<LoginCubit>().login("0${state.number}");
                      }
                    : null,
                buttonChild: const Text("ارسال کد"),
              );
      },
    );
  }
}
