part of 'number_page.dart';

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
