part of 'verify_page.dart';

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
