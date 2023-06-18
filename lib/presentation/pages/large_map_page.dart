import 'package:dobareh_bloc/business_logic/map/map_cubit.dart';
import 'package:dobareh_bloc/presentation/components/general/location_checker.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../data/model/home/home_response.dart';
import '../../utils/colors.dart';
import '../../utils/enums.dart';
import '../components/large_map/large_map_widget.dart';
import '../components/large_map/map_list_item.dart';
import 'order_datails_page.dart';

class LargeMapPage extends StatelessWidget {
  const LargeMapPage({Key? key}) : super(key: key);

  static Widget router(Map<DeliveryTime, List<Orders>> timePacks,
      Orders? inProgressOrder, int selectedTime) {
    return BlocProvider(
      create: (context) => MapCubit(timePacks, inProgressOrder, selectedTime),
      child: const LargeMapPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Get.off(const HomePage());
        return Future.value(true);
      },
      child: Scaffold(
        body: LargeMapBody(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(66.h),
            child: const LargeMapAppbar()),
      ),
    );
  }
}

class LargeMapAppbar extends StatelessWidget {
  const LargeMapAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        // height: 48.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  // Get.off(const HomePage());
                  Get.back();
                },
                icon: SvgPicture.asset("assets/icons/arrow_right.svg",
                    color: secondary)),
            Expanded(
              child: Text("مسیر روی نقشه",
                  style: textTheme.bodySmall?.copyWith(color: secondary)),
            ),
            BlocBuilder<MapCubit, MapState>(
              buildWhen: (pState, nState) {
                return pState.selectedTime != nState.selectedTime;
              },
              builder: (BuildContext context, state) {
                var selectedTimePack =
                    state.timePacks.keys.elementAt(state.selectedTime);
                return PopupMenuButton<int>(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  onSelected: (selectedTime) {
                    context.read<MapCubit>().timeSelected(selectedTime);
                  },
                  itemBuilder: (BuildContext context) {
                    return List<PopupMenuItem<int>>.generate(
                        state.timePacks.keys.length, (index) {
                      var timePack = state.timePacks.keys.elementAt(index);
                      return PopupMenuItem(
                          value: index,
                          child: Row(
                            children: [
                              Theme(
                                data: Theme.of(context)
                                    .copyWith(disabledColor: primary),
                                child: Checkbox(
                                  value: state.selectedTime == index,
                                  onChanged: null,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Text(
                                  "${timePack.from} تا  ${timePack.to}",
                                  style: textTheme.titleSmall,
                                ),
                              ),
                            ],
                          ));
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 106.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        border: Border.all(color: secondaryTint2),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${selectedTimePack.from} تا  ${selectedTimePack.to}"),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child:
                              SvgPicture.asset("assets/icons/arrow_down.svg"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LargeMapBody extends StatelessWidget {
  LargeMapBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    PageController pageController =
        PageController(initialPage: 0, keepPage: false);
    return SafeArea(
      child: Column(
        children: [
/*
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(children: []),
            ),
          ),*/

          Expanded(
              child: BlocConsumer<MapCubit, MapState>(
            listenWhen: (pState, nState) {
              var change = pState.selectedTime != nState.selectedTime;
              return change;
            },
            listener: (context, state) {
              pageController.jumpToPage(0);
            },
            buildWhen: (pState, nState) {
              return pState.selectedTime != nState.selectedTime;
            },
            builder: (BuildContext context, state) {
              var selectedTimePack =
                  state.timePacks.values.elementAt(state.selectedTime);
              // pageController.jumpToPage(state.selectedOrder);
              return Stack(
                children: [
                  selectedTimePack.isEmpty
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 60.h),
                          child: Column(children: [
                            SvgPicture.asset("assets/icons/empty.svg"),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 10.h, bottom: 100.h),
                              child: Text(
                                "برای این بازه زمانی جمع آوری وجود ندارد",
                                style: textTheme.bodyLarge?.copyWith(
                                  color: natural6,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: 100.h),
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: LocationCheckerWidget(
                                mapWidget: LargeMapWidget(
                                  orders: selectedTimePack,
                                  pageController: pageController,
                                ),
                              )),
                        ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: 500.h),
                        child: PageView(
                          controller: pageController,
                          // restorationId: null,
                          onPageChanged: (int page) {
                            context.read<MapCubit>().orderSelected(page);
                          },
                          children: List<Widget>.generate(
                              selectedTimePack.length, (index) {
                            var item = selectedTimePack.elementAt(index);
                            if (item.status == OrderStatus.waiting.value) {
                              return MapListItem(
                                personName: item.deliveryPersonName ??
                                    "نام و نام خانوادگی",
                                address: item.address?.address ?? "آدرس",
                                onPressed: state.inProgressOrder == null
                                    ? () {
                                        // Get.back();
                                        Get.to(OrderDetailsPage.router(
                                            orderID: item.id!.toInt()));
                                      }
                                    : () {
                                        context.showToast(
                                            message:
                                                "شما یک سفارش در حال پردازش دارید.",
                                            messageType: MessageType.warning);
                                      },
                                isActive: false,
                              );
                            } else {
                              return MapListItem(
                                backgroundColor: secondaryTint2,
                                personName: item.deliveryPersonName ??
                                    "نام و نام خانوادگی",
                                address: item.address?.address ?? "آدرس",
                                onPressed: () {
                                  // Get.back();
                                  Get.to(OrderDetailsPage.router(
                                      orderID: item.id!.toInt()));
                                },
                                isActive: true,
                              );
                            }
                          }),
                        ) /*PageView.builder(
                        controller: pageController,
                        onPageChanged: (int page) {

                          context.read<MapCubit>().orderSelected(page);

                        },
                        padEnds: false,
                        itemCount: selectedTimePack.length,
                        itemBuilder: (BuildContext context, int index) {

                        },
                      ),*/
                        ),
                  ),
                ],
              );
            },
          )),
        ],
      ),
    );
  }
}
