import 'package:dobareh_bloc/business_logic/home/home_cubit.dart';
import 'package:dobareh_bloc/data/model/order/orders_list_response.dart';
import 'package:dobareh_bloc/presentation/components/general/retry_widget.dart';
import 'package:dobareh_bloc/presentation/pages/orders_list_page.dart';
import 'package:dobareh_bloc/presentation/pages/support_page.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:dobareh_bloc/utils/icon_assistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../business_logic/auth/authentication_cubit.dart';
import '../../utils/colors.dart';
import '../components/general/loading_widget.dart';
import '../components/home/account_exit_dialog.dart';
import '../components/menu/menu_item.dart';
import 'account_info_page.dart';
import 'home_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.homeStatus == HomeStatus.success) {
          var homeResponse = state.homeResponse!;
          return Scaffold(
            body: Column(
              children: [
                SizedBox(
                  // height: 250.h,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200.h,
                        color: const Color.fromRGBO(161, 210, 150, 0.2),
                        child: SvgPicture.asset(
                          "assets/images/menu_top.svg",
                          // height: 180.h,
                          fit: BoxFit.cover,
                          // width:double.infinity,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 150.h),
                        // height: 112.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24.r))),
                        padding: EdgeInsets.only(left: 80.w),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: Text(
                                "${homeResponse.user?.firstName} ${homeResponse.user?.lastName}",
                                style: textTheme.titleMedium
                                    ?.copyWith(color: primaryShade2),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                              child: Text(
                                "${homeResponse.user?.mobile}",
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: primaryShade2),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 16.h,
                        // left: 80.w,
                        right: 32.w,
                        child: ClipOval(
                          child: Image.network(
                            "${homeResponse.user?.image}",
                          width: 140.r,
                          height: 140.r,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              width: 140.r,
                              height: 140.r,
                              child: const Center(
                                child: LoadingWidget(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                        top: 26.h,
                        right: 5.w,
                        child: IconAssistant.backIconButton(() {
                          Get.back();
                        })),
                  ],
                  ),
                ),
                Expanded(
                  child: ColoredBox(
                    color: white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ///two box
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    // width: 156.w,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.h, horizontal: 16.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        border: const Border.fromBorderSide(
                                            BorderSide(color: secondaryTint2)),
                                        color: background),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        "کل جمع آوری امروز",
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: primary),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 30.h),
                                          child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "${homeResponse.todayDeliveredCount}",
                                                  style: textTheme.displaySmall
                                                      ?.copyWith(
                                                          color: natural2)),
                                              TextSpan(
                                                  text: " عدد",
                                                  style: textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: natural4)),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    // width: 156.w,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.h, horizontal: 16.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        border: const Border.fromBorderSide(
                                            BorderSide(color: secondaryTint2)),
                                        color: background),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "امتیاز شما",
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodyMedium
                                              ?.copyWith(color: primary),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 30.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text("0  ",
                                                  style: textTheme.displaySmall
                                                      ?.copyWith(
                                                          color: natural2)),
                                              SvgPicture.asset(
                                                  "assets/icons/coin.svg")
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: ProfileMenuItem(
                                svgAsset: "assets/icons/sattus.svg",
                                text: "گزارشات و آنالیزها",
                                onTap: () {
                                  context.showToast(
                                      message: 'به زودی',
                                      messageType: MessageType.info);
                                }),
                          ),
                          ProfileMenuItem(
                              svgAsset: "assets/icons/note.svg",
                              text: "لیست جمع آوری",
                              onTap: () {
                                var toadyString =
                                homeResponse.today?.date ?? "1402-01-01";
                            Jalali today = Jalali(
                              int.parse(toadyString.substring(0, 4)),
                              int.parse(toadyString.substring(5, 7)),
                              int.parse(toadyString.substring(8, 10)),
                            );
                            HomePage.refreshData = true;

                            Get.to(OrdersListPage.router(
                                today,
                                state.inProgressOrder == null
                                    ? null
                                    : Orders.fromJson(
                                        state.inProgressOrder?.toJson())));
                          }),
                          ProfileMenuItem(
                              svgAsset: "assets/icons/support.svg",
                              text: "پشتیبانی ",
                              onTap: () {
                                HomePage.refreshData = false;
                            Get.to(SupportPage.router());
                          }),
                          ProfileMenuItem(
                              svgAsset: "assets/icons/account_info.svg",
                              text: "اطلاعات حساب کاربری",
                              onTap: () {
                                HomePage.refreshData = false;
                            Get.to(AccountInfoPage.router());
                          }),
                          ProfileMenuItem(
                              svgAsset: "assets/icons/about.svg",
                              text: "درباره ما",
                              onTap: () {
                                context.showToast(
                                    message: 'به زودی',
                                    messageType: MessageType.info);
                              }),
                          ProfileMenuItem(
                              svgAsset: "assets/icons/exit.svg",
                              text: "خروج",
                              onTap: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                builder: (context) {
                                  return const AccountExitDialog();
                                }).then((value) {
                              if (value == true) {
                                context
                                    .read<AuthenticationCubit>()
                                    .logoutRequested();
                              }
                            });
                          }),
                    ]),
                  ),
                ),
              )
            ]),
          );
        } else if (state.homeStatus == HomeStatus.failure) {
          return FailureWidget(
              errorMessage: state.errorMessage,
              onRetryPressed: () {
                context.read<HomeCubit>().getHomeRequested();
              });
        } else {
          return Container(color: Colors.white, child: const LoadingWidget());
        }
      },
    );
  }
}
