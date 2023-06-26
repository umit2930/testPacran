import 'package:dobareh_bloc/business_logic/support/support_cubit.dart';
import 'package:dobareh_bloc/presentation/components/general/loading_widget.dart';
import 'package:dobareh_bloc/presentation/components/general/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../data/model/support/support_response.dart';
import '../../utils/colors.dart';
import '../../utils/icon_assistant.dart';
import '../components/general/call_support_bottomsheet.dart';
import '../components/general/custom_filled_button.dart';
import '../components/support/support_item.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  static Widget router() {
    return BlocProvider(
        create: (context) => SupportCubit(), child: const SupportPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(66.h), child: const SupportAppbar()),
        body: const SupportBody());
  }
}

class SupportAppbar extends StatelessWidget {
  const SupportAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 8.h),
        child: Row(
          children: [
            IconAssistant.backIconButton(() => Get.back()),
            Text(
              "پشتیبانی",
              style: textTheme.bodyMedium?.copyWith(color: secondary),
            )
          ],
        ),
      ),
    );
  }
}

class SupportBody extends StatelessWidget {
  const SupportBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: BlocBuilder<SupportCubit, SupportState>(builder: (context, state) {
        switch (state.supportsStatus) {
          case SupportsStatus.initial:
            context.read<SupportCubit>().supportsRequested();
            return const LoadingWidget();
          case SupportsStatus.loading:
            return const LoadingWidget();
          case SupportsStatus.failure:
            return FailureWidget(onRetryPressed: () {});
          case SupportsStatus.success:
            var supports = state.supportResponse!.supports;
            var number = state.supportResponse!.number ?? "09";
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.only(top: 25.h, left: 16.w, right: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "نیاز به پشتیبانی دارید؟",
                          style: textTheme.bodySmall?.copyWith(color: natural1),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.only(top: 25.h),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return SupportItem(
                                onTap: () {
                                  //TODO navigate to answer page
                                  /*showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const SupportAnswerPage();
                                  });*/
                                },
                                support:
                                    supports?.elementAt(index) ?? Supports());
                          },
                          itemCount: supports?.length,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 25.h, horizontal: 16.w),
                  child: CustomFilledButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: false,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return CallSupportBottomsheet(number: number);
                          });
                    },
                    buttonChild: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/call.svg",
                          color: white,
                        ),
                        const Text("  تماس با پشتیبانی")
                      ],
                    ),
                    width: double.infinity,
                  ),
                )
              ],
            );
        }
      }),
    );
  }
}
