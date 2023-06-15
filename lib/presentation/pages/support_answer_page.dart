import 'package:dobareh_bloc/business_logic/support/support_answer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/icon_assistant.dart';
import '../components/general/loading_widget.dart';
import '../components/general/retry_widget.dart';

class SupportAnswerPage extends StatelessWidget {
  const SupportAnswerPage({Key? key}) : super(key: key);

  static Widget router(int selectedSupportID) {
    return BlocProvider(
        create: (context) => SupportAnswerCubit(selectedSupportID),
        child: const SupportAnswerPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(66.h),
            child: const SupportAnswerAppbar()),
        body: const SupportAnswerBody());
  }
}

class SupportAnswerAppbar extends StatelessWidget {
  const SupportAnswerAppbar({Key? key}) : super(key: key);

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
              "پاسخ",
              style: textTheme.bodyMedium?.copyWith(color: secondary),
            )
          ],
        ),
      ),
    );
  }
}

class SupportAnswerBody extends StatelessWidget {
  const SupportAnswerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SupportAnswerCubit, SupportAnswerState>(
        builder: (context, state) {
      switch (state.supportAnswerStatus) {
        case SupportAnswerStatus.initial:
          context.read<SupportAnswerCubit>().supportAnswerRequested();
          return const LoadingWidget();
        case SupportAnswerStatus.loading:
          return const LoadingWidget();
        case SupportAnswerStatus.failure:
          return FailureWidget(onRetryPressed: () {});
        case SupportAnswerStatus.success:
          var support = state.supportAnswerResponse!.support;
          return SingleChildScrollView(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  support?.question ?? "سوال",
                  style: textTheme.titleSmall?.copyWith(color: natural1),
                ),
                Text(
                  support?.answer ?? "پاسخ سوال",
                  style: textTheme.bodySmall?.copyWith(color: natural1),
                )
              ],
            ),
          );
      }
    });
  }
}
