import 'package:dobareh_bloc/business_logic/home/home_cubit.dart';
import 'package:dobareh_bloc/presentation/components/home/app_exit_dialog.dart';
import 'package:dobareh_bloc/presentation/pages/menu_page.dart';
import 'package:dobareh_bloc/utils/icon_assistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../components/general/loading_widget.dart';
import '../components/general/retry_widget.dart';
import '../components/home/map_widget.dart';
import '../components/home/orders_widget.dart';
import '../components/home/summery_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget router() {
    return BlocProvider(
      create: (BuildContext context) {
        return HomeCubit();
      },
      child: const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var result = await showDialog<bool>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const AppExitDialog();
            });
        if (result == null) {
          return Future.value(false);
        } else {
          return Future.value(result);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(66.h), child: const HomeAppbar()),
        body: const HomeBody(),
        drawer: const MenuPage(),
      ),
    );
  }
}

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        height: 66.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAssistant.menuIconButton(() {
              var isSuccess = (context.read<HomeCubit>().state.homeStatus ==
                  HomeStatus.success);
              if (isSuccess) {
                Scaffold.of(context).openDrawer();
              }
            }),
            SvgPicture.asset("assets/icons/logo.svg"),
            IconAssistant.notificationIconButton(() {}),
          ],
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget with WidgetsBindingObserver {
  const HomeBody({Key? key}) : super(key: key);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Logger().i(state.name);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeCubit, HomeState>(
          builder: (BuildContext context, state) {
        switch (state.homeStatus) {
          case HomeStatus.initial:
            context.read<HomeCubit>().getHomeRequested();
            return const LoadingWidget();
          case HomeStatus.loading:
            return const LoadingWidget();
          case HomeStatus.failure:
            return FailureWidget(
              onRetryPressed: () {
                context.read<HomeCubit>().getHomeRequested();
              },
              errorMessage: state.errorMessage,
            );
          case HomeStatus.success:
            return SingleChildScrollView(
              child: Column(
                children: [
                  ///map
                  Padding(
                      padding:
                          EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                      child: const OpenStreetMapWidget()),

                  ///summery
                      Padding(
                          padding:
                          EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                          child: const SummeryWidget()),

                      ///orders list
                      Padding(
                          padding: EdgeInsets.only(top: 32.h),
                          child: const HomeOrdersWidget())
                    ],
                  ),
                );
            }
          }),
    );
  }
}
