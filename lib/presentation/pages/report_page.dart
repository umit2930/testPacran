import 'package:dobareh_bloc/business_logic/report/report_cubit.dart';
import 'package:dobareh_bloc/presentation/components/general/loading_widget.dart';
import 'package:dobareh_bloc/presentation/components/general/retry_widget.dart';
import 'package:dobareh_bloc/presentation/components/support/report_item.dart';
import 'package:dobareh_bloc/presentation/pages/report_answer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../data/model/report/report_response.dart';
import '../../utils/colors.dart';
import '../../utils/icon_assistant.dart';
import '../components/general/call_support_bottomsheet.dart';
import '../components/general/custom_filled_button.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  static Widget router() {
    return BlocProvider(
        create: (context) => ReportCubit(), child: const ReportPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(66.h), child: const ReportAppbar()),
        body: const ReportBody());
  }
}

class ReportAppbar extends StatelessWidget {
  const ReportAppbar({Key? key}) : super(key: key);

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
              "گزارش مشکل",
              style: textTheme.bodyMedium?.copyWith(color: secondary),
            )
          ],
        ),
      ),
    );
  }
}

class ReportBody extends StatelessWidget {
  const ReportBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: BlocBuilder<ReportCubit, ReportState>(builder: (context, state) {
        switch (state.reportStatus) {
          case ReportStatus.initial:
            context.read<ReportCubit>().reportsRequested();
            return const LoadingWidget();
          case ReportStatus.loading:
            return const LoadingWidget();
          case ReportStatus.failure:
            return FailureWidget(onRetryPressed: () {});
          case ReportStatus.success:
            var reports = state.reportResponse!.report;
            var number = state.reportResponse!.mobile ?? "09";
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
                            return ReportItem(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ReportAnswerPage.router(
                                            reports?.elementAt(index) ??
                                                Report());
                                      });
                                },
                                report: reports?.elementAt(index) ?? Report());
                          },
                          itemCount: reports?.length,
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
