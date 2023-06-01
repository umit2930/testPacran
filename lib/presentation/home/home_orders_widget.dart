import 'package:dobareh_bloc/business_logic/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/model/home/home_response.dart';
import '../../utils/colors.dart';
import '../../utils/enums.dart';
import '../../utils/extension.dart';
import 'home_order_item.dart';

class HomeOrdersWidget extends StatefulWidget {
  const HomeOrdersWidget({Key? key}) : super(key: key);

  @override
  State<HomeOrdersWidget> createState() => _HomeOrdersWidgetState();
}

class _HomeOrdersWidgetState extends State<HomeOrdersWidget> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "لیست جمع آوری امروز",
                style: textTheme.bodyLarge?.copyWith(color: natural1),
              ),
              TextButton(
                  style: TextButton.styleFrom(foregroundColor: secondary),
                  onPressed: () {
                    /*     var toadyString =
                                    model.today?.date ?? "1402-01-01";
                                Jalali today = Jalali(
                                  int.parse(toadyString.substring(0, 4)),
                                  int.parse(toadyString.substring(5, 7)),
                                  int.parse(toadyString.substring(8, 10)),
                                );*/
                    /* Get.to(OrdersListPage(
                                    today: today,
                                  ));*/
                  },
                  child: Text(
                    "تاریخچه",
                    style: textTheme.bodyLarge?.copyWith(color: secondary),
                  ))
            ],
          ),
        ),
        Container(
            clipBehavior: Clip.antiAlias,
            width: double.infinity,
            decoration: boxDecoration,
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (BuildContext context, state) {
                var selectedID = state.selectedTimePackID;
                Map<DeliveryTime, List<Orders>> timePacks = state.timePacks!;

                var selectedTimePack = timePacks.values.elementAt(selectedID);
                var selectedTimePackDelivery =
                    timePacks.keys.elementAt(selectedID);
                List<Widget> choicesPacks = [];

                timePacks.forEach((key, value) {
                  // if (value.isNotEmpty) {
                  choicesPacks.add(
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "${key.from} الی ${key.to}",
                            style: textTheme.titleSmall),
                        TextSpan(
                            text: " ( ${value.length} مسیر)",
                            style: textTheme.bodySmall),
                      ]),
                    ),
                  );
                  // }
                });

                return Column(
                  children: [
                    SingleChildScrollView(
                        padding: EdgeInsets.only(
                            top: 20.h, left: 20.w, right: 20.w, bottom: 20.h),
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                            spacing: 8.w,
                            children: List.generate(
                              choicesPacks.length,
                              (index) {
                                bool isSelected = (selectedID == index);
                                return ChoiceChip(
                                  labelPadding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.sp)),
                                  label: Container(
                                    alignment: Alignment.center,
                                    // width: 133.w,
                                    // height: 42.h,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 14.w),
                                    child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            (isSelected ? white : black),
                                            BlendMode.srcATop),
                                        child: choicesPacks[index]),
                                  ),

                                  // selected: cryptoProvider.selectedIndex == index,
                                  selectedColor: black,
                                  backgroundColor: Colors.transparent,
                                  selected: isSelected,
                                  onSelected: (bool selected) {
                                    context
                                        .read<HomeCubit>()
                                        .timePackSelected(index);
                                    // homeViewModel.selectItem(index);
                                  },
                                );
                              },
                            ))),

                    ///Orders list
                    getItemsListWidget(
                        selectedTimePack, textTheme, selectedTimePackDelivery),
                  ],
                );
              },
            )),
      ],
    );
  }

  Widget getItemsListWidget(List<Orders> selectedTimePack, TextTheme textTheme,
      DeliveryTime deliveryTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
/*
        ///In process item
        if (homeViewModel.inProgressOrder != null &&
            homeViewModel.inProgressOrder?.deliveryTime?.from ==
                deliveryTime.from) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("در حال جمع آوری مواد بازیافتی"),
                HomeOrderItem(
                  isActive: true,
                  backgroundColor: secondaryTint2,
                  personName:
                  homeViewModel.inProgressOrder?.deliveryPersonName ??
                      "نام و نام خانوادگی",
                  address:
                  homeViewModel.inProgressOrder?.address?.address ?? "آدرس",
                  onPressed: () {
                    */
/* Get.to(
                      SellePage(
                        orderID: homeViewModel.inProgressOrder!.id!.round(),
                      ),
                    );*/ /*

                  },
                )
              ],
            ),
          )
        ],
*/

        ///waiting items
        if (selectedTimePack
            .where((element) => element.status == OrderStatus.waiting.value)
            .isNotEmpty) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 14.h,
                  left: 20.w,
                  right: 20.w,
                ),
                child: Text(
                  "در صف انتظار",
                  style: textTheme.bodyMedium?.copyWith(color: natural1),
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 80.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var item = selectedTimePack
                      .where((element) =>
                          element.status == OrderStatus.waiting.value)
                      .elementAt(index);
// return Text("hello");
                  return HomeOrderItem(
                      isActive: false,
                      personName: item.deliveryPersonName!,
                      address: item.address!.address!,
                      onPressed:
                          /*  homeViewModel.inProgressOrder == null
                          ? () {
                        // Get.to(SellePage(orderID: item.id!.toInt()));
                      }
                          :*/
                          () {
                        context.showToast(
                          message: "شما یک سفارش در حال پردازش دارید!",
                          messageType: MessageType.warning,
                        );
                      });
                },
                itemCount: selectedTimePack
                    .where((element) =>
                        element.status == OrderStatus.waiting.value)
                    .length,
              ),
            ],
          )
        ],

        ///empty box
        if (selectedTimePack.isEmpty) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 60.h),
            child: Column(children: [
              SvgPicture.asset("assets/icons/empty.svg"),
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 100.h),
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
        ],

        /* ///padding
        if (selectedTimePack
            .where((element) => element.status == OrderStatus.waiting.value)
            .isEmpty &&
            homeViewModel.inProgressOrder != null) ...[
          SizedBox(
            height: 50.h,
          )
        ],*/
      ],
    );
  }
}
