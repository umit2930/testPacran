import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/login/login_cubit.dart';
import '../general/custom_filled_button.dart';
import '../general/loading_widget.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (BuildContext context, LoginState state) {
        return (state.loginStatus == LoginStatus.loading)
            ? const Center(child: LoadingWidget())
            : CustomFilledButton(
                onPressed: (state.number.length > 9)
                    ? () {
                        context
                            .read<LoginCubit>()
                            .loginSubmitted("0${state.number}");
                      }
                    : null,
                buttonChild: const Text("ارسال کد"),
              );
      },
    );
  }
}
