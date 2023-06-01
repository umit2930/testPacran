import 'package:dobareh_bloc/business_logic/home/home_cubit.dart';
import 'package:dobareh_bloc/data/repository/home_repository.dart';
import 'package:dobareh_bloc/presentation/components/loading_widget.dart';
import 'package:dobareh_bloc/presentation/home/open_street_map_widget.dart';
import 'package:dobareh_bloc/utils/icon_assistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/model/home/home_response.dart';
import '../../utils/colors.dart';
import '../components/retry_widget.dart';
import 'home_orders_widget.dart';

part 'summery_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget router() {
    return BlocProvider(
      create: (BuildContext context) {
        return HomeCubit(homeRepository: context.read<HomeRepository>());
      },
      child: const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h), child: const HomeAppbar()),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
      switch (state.homeStatus) {
        case HomeStatus.initial:
          context.read<HomeCubit>().getHomeRequested();
          return const LoadingWidget();
        case HomeStatus.loading:
          return const LoadingWidget();
        case HomeStatus.failure:
          return getFailureWidget(
              errorMessage: state.errorMessage,
              onRetryPressed: () {
                context.read<HomeCubit>().getHomeRequested();
              });
        case HomeStatus.success:
          return const HomeSuccessWidget();
      }
    }));
  }
}

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        height: 56.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAssistant.menuIconButton(() => () {
                  Scaffold.of(context).openDrawer();
                }),
            SvgPicture.asset("assets/icons/logo.svg"),
            IconAssistant.notificationIconButton(() {}),
          ],
        ),
      ),
    );
  }
}

class HomeSuccessWidget extends StatelessWidget {
  const HomeSuccessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///map
            Padding(
                padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                child: OpenStreetMapWidget()),

            ///summery
            Padding(
                padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                child: const SummeryWidget()),

            ///list title
            Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: const HomeOrdersWidget())
          ],
        ),
      ),
    );
  }
}
