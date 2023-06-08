import 'package:dobareh_bloc/business_logic/order/calculate_values_cubit.dart';
import 'package:dobareh_bloc/presentation/components/general/loading_widget.dart';
import 'package:dobareh_bloc/presentation/components/general/retry_widget.dart';
import 'package:dobareh_bloc/utils/icon_assistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../components/calculate_values/bottom_actions_widget.dart';
import '../components/calculate_values/categories_list.dart';
import 'order_datails_page.dart';

class CalculateValuesPage extends StatelessWidget {
  const CalculateValuesPage({Key? key}) : super(key: key);

  static Widget router(int orderID) {
    return BlocProvider<CalculateValuesCubit>(
        create: (context) {
          return CalculateValuesCubit(orderID: orderID);
        },
        child: const CalculateValuesPage());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Get.off(
            OrderDetailsPage.router(
              orderID: context.read<CalculateValuesCubit>().state.orderID,
            ),
          );
          return Future.value(false);
        },
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(66.h),
                child: const CalculateValuesAppbar()),
            body: const CalculateValuesBody()));
  }
}

class CalculateValuesAppbar extends StatelessWidget {
  const CalculateValuesAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 8.h),
        child: Row(
          children: [
            IconAssistant.backIconButton(() => Get.off(
                  OrderDetailsPage.router(
                    orderID: context.read<CalculateValuesCubit>().state.orderID,
                  ),
                )),
            Text(
              "محاسبه مقادیر",
              style: textTheme.bodyMedium?.copyWith(color: secondary),
            )
          ],
        ),
      ),
    );
  }
}

class CalculateValuesBody extends StatelessWidget {
  const CalculateValuesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return BlocBuilder<CalculateValuesCubit, CalculateValuesState>(
      buildWhen: (pState, nState) {
        var rebuild =
            pState.calculateValuesStatus != nState.calculateValuesStatus;
        return rebuild;
      },
      builder: (context, state) {
        switch (state.calculateValuesStatus) {
          case CalculateValuesStatus.init:
            context.read<CalculateValuesCubit>().categoriesRequested();
            return const LoadingWidget();
          case CalculateValuesStatus.loading:
            return const LoadingWidget();
          case CalculateValuesStatus.error:
            return FailureWidget(onRetryPressed: () {
              context.read<CalculateValuesCubit>().categoriesRequested();
            });
          case CalculateValuesStatus.success:
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                  child: Text(
                    "مقایر تحویل داده شده توسط فروشنده را وارد کنید.",
                    style: textTheme.bodyMedium?.copyWith(color: natural1),
                  ),
                ),
                const Expanded(child: CategoriesList()),
                const BottomActions(),
              ],
            );
        }
      },
    );
  }
}
