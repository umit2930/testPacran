import 'package:dobareh_bloc/business_logic/report/report_answer_cubit.dart';
import 'package:dobareh_bloc/presentation/components/general/custom_filled_button.dart';
import 'package:dobareh_bloc/presentation/components/general/loading_widget.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/model/report/ReportResponse.dart';
import '../../utils/colors.dart';
import '../../utils/icon_assistant.dart';

class ReportAnswerPage extends StatelessWidget {
  const ReportAnswerPage({Key? key}) : super(key: key);

  static Widget router(Report report) {
    return BlocProvider(
        create: (context) => ReportAnswerCubit(report),
        child: const ReportAnswerPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(66.h),
            child: const ReportAnswerAppbar()),
        body: BlocListener<ReportAnswerCubit, ReportAnswerState>(
          listenWhen: (pState, nState) {
            return (pState.sendReportStatus != nState.sendReportStatus);
          },
          listener: (context, state) {
            switch (state.sendReportStatus) {
/*              case SendReportStatus.loading:
                showDialog(
                    context: context,
                    builder: (context) {
                      return const LoadingWidget();
                    });
                break;*/
              case SendReportStatus.failure:
                context.showToast(
                    message: state.errorMessage,
                    messageType: MessageType.error);
                break;
              case SendReportStatus.success:
                context.showToast(
                    message: "مشکل با موفقیت ارسال شد.",
                    messageType: MessageType.success);
                break;
              default:
                break;
            }
          },
          child: const ReportAnswerBody(),
        ));
  }
}

class ReportAnswerAppbar extends StatelessWidget {
  const ReportAnswerAppbar({Key? key}) : super(key: key);

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

class ReportAnswerBody extends StatelessWidget {
  const ReportAnswerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: BlocBuilder<ReportAnswerCubit, ReportAnswerState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 25.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.report.question ?? "مشکل",
                        style: textTheme.titleSmall?.copyWith(color: natural1),
                      ),
                      Text(
                        state.report.answer ?? "پاسخ مشکل",
                        style: textTheme.bodySmall?.copyWith(color: natural1),
                      )
                    ],
                  ),
                ),
              ),
              if (state.sendReportStatus == SendReportStatus.loading) ...[
                Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 25.h, horizontal: 16.w),
                    child: const LoadingWidget())
              ] else ...[
                Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 25.h, horizontal: 16.w),
                    child: CustomFilledButton(
                      onPressed: () {
                        context.read<ReportAnswerCubit>().sendReport();
                      },
                      buttonChild: const Text("ارسال مشکل"),
                      width: double.infinity,
                    ))
              ]
            ],
          );
        },
      ),
    );
  }
}
