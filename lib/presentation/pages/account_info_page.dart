import 'package:dobareh_bloc/business_logic/profile/profile_cubit.dart';
import 'package:dobareh_bloc/utils/icon_assistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../components/general/loading_widget.dart';
import '../components/general/retry_widget.dart';
import '../components/profile/account_info_item.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({Key? key}) : super(key: key);

  static Widget router() {
    return BlocProvider(
      create: (context) {
        return ProfileCubit();
      },
      child: const AccountInfoPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: const AccountInfoAppbar(),
        ),
        body: const AccountInfoBody());
  }
}

class AccountInfoAppbar extends StatelessWidget {
  const AccountInfoAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        height: 66.h,
        child: Row(
          children: [
            IconAssistant.backIconButton(() => Get.back()),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "اطلاعات حساب کاربری",
                style: textTheme.bodySmall?.copyWith(color: secondary),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AccountInfoBody extends StatelessWidget {
  const AccountInfoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        switch (state.profileStatus) {
          case ProfileStatus.init:
            context.read<ProfileCubit>().profileRequested();
            return const LoadingWidget();
          case ProfileStatus.loading:
            return const LoadingWidget();
          case ProfileStatus.error:
            return FailureWidget(
              onRetryPressed: () {
                context.read<ProfileCubit>().profileRequested();
              },
              errorMessage: state.errorMessage,
            );
          case ProfileStatus.success:
            var profileModel = state.profileResponse!;

            //TODO check text align to be correct
            String plateNumber = "";

            plateNumber +=
                "${profileModel.user?.plateNumber?.state.toString()} - ";
            plateNumber +=
                "${profileModel.user?.plateNumber?.first.toString()} ";
            plateNumber +=
                "${profileModel.user?.plateNumber?.letter.toString()} ";
            plateNumber +=
                "${profileModel.user?.plateNumber?.second.toString()} ";

            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25.h),
                            child: ClipOval(
                              child: Image.network(
                                "${profileModel.user?.image}",
                                width: 80.w,
                                fit: BoxFit.cover,
                                height: 80.w,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    width: 156.w,
                                    height: 156.h,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          ///car
                          Container(
                            margin: EdgeInsets.only(top: 16.h),
                            padding: EdgeInsets.only(
                                top: 11.h,
                                left: 16.w,
                                right: 16.w,
                                bottom: 18.h),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(120, 187, 104, 1),
                                  Color.fromRGBO(60, 151, 38, 1),
                                ]),
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("اطلاعات ماشین",
                                    style: textTheme.bodyMedium
                                        ?.copyWith(color: white)),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/car.svg",
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                            "${profileModel.user?.carName} ${profileModel.user?.carColor}",
                                            style: textTheme.bodySmall
                                                ?.copyWith(color: white)),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        height: 38.h,
                                        width: 104.w,
                                        child: Text(plateNumber,
                                            style: textTheme.bodyMedium
                                                ?.copyWith(color: natural2)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          ///info
                          AccountInfoItem(
                            title: 'نام و نام خانوادگی',
                            value:
                                "${profileModel.user?.firstName} ${profileModel.user?.lastName}",
                            onTap: () {},
                          ),
                          AccountInfoItem(
                            title: 'شماره تلفن همراه',
                            value: "${profileModel.user?.mobile}",
                            onTap: () {},
                          ),
                          AccountInfoItem(
                            title: 'کد ملی',
                            value: "${profileModel.user?.nationalCode}",
                            onTap: () {},
                          ),
                          AccountInfoItem(
                            title: 'شماره تلفن ثابت',
                            value:
                                "${profileModel.user?.landlineNumber?.code} - ${profileModel.user?.landlineNumber?.number}",
                            onTap: () {},
                          ),
                          AccountInfoItem(
                            title: 'شماره شبا',
                            value: "${profileModel.user?.shabaNumber}",
                            onTap: () {},
                          ),
                          AccountInfoItem(
                            title: 'پست الکترونیک',
                            value: profileModel.user?.email.toString() ??
                                "پست الکترونیک",
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
