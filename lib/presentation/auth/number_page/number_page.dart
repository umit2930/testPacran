import 'package:dobareh_bloc/business_logic/auth/login/login_cubit.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';
import 'package:dobareh_bloc/presentation/auth/code_page/verify_page.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../components/custom_filled_button.dart';
import '../../components/loading_widget.dart';

part 'login_button.dart';
part 'number_field_widget.dart';

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
          Get.off(VerifyPage.router(
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
                        child: const NumberFieldWidget(),
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
