import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../business_logic/orders_list/orders_list_cubit.dart';
import '../../utils/colors.dart';
import '../../utils/icon_assistant.dart';
import '../components/orders_list/delivered_tab.dart';
import '../components/orders_list/warehouse_tab.dart';
import '../components/orders_list/wating_tab.dart';
import 'home_page.dart';
import 'order_datails_page.dart';

class OrdersListPage extends StatelessWidget {
  const OrdersListPage({Key? key}) : super(key: key);

  static Widget router(Jalali todayDate) {
    return BlocProvider(
      create: (context) => OrdersListCubit(todayDate: todayDate),
      child: const OrdersListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var cubit = context.read<OrdersListCubit>();

/*    cubit.stream.listen((event) {
      print(event);
    });

    cubit.timePackSelected(index: 2);
    cubit.tabSelected(index: 1);

    cubit.dateSelected(date: Jalali.fromDateTime(DateTime(2023, 06, 08)));
    cubit.deliveredOrdersRequested();*/
    return Scaffold(backgroundColor: white, appBar: PreferredSize(
      preferredSize: Size.fromHeight(66.h),
      child: const OrdersListAppbar(),
    ),body: const OrdersListBody());
  }
}
class OrdersListAppbar extends StatelessWidget {
  const OrdersListAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        // height: 66.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconAssistant.backIconButton(() => Get.back()),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("لیست جمع آوری",
                  style: textTheme.bodySmall?.copyWith(color: secondary)),
            ),

          ],
        ),
      ),
    );
  }
}

class OrdersListBody extends StatelessWidget {
  const OrdersListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<OrdersListCubit, OrdersListState>(
          buildWhen: (pState, nState) {
        return pState.selectedTab != nState.selectedTab;
      }, builder: (context, state) {
        return Column(
          children: [
            Container(color: background,
              child: ChoicesWidget(
                state: state,
              ),
            ),
            Expanded(
              child: TabsWidget(
                state: state,
              ),
            )
          ],
        );
      }),
    );
  }
}

class ChoicesWidget extends StatelessWidget {
  const ChoicesWidget({
    super.key,
    required this.state,
  });

  final OrdersListState state;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final choicesList = [
      Text("در انتظار  ", style: textTheme.titleSmall),
      Text("تحویل گرفته شده  ", style: textTheme.titleSmall),
      Text("تحویل به انبار  ", style: textTheme.titleSmall),
    ];

    return SingleChildScrollView(
        padding:
            EdgeInsets.only(top: 10.h, left: 8.w, right: 8.w, bottom: 20.h),
        scrollDirection: Axis.horizontal,
        child: Wrap(
            spacing: 8.w,
            children: List.generate(
              choicesList.length,
              (index) {
                bool isSelected = (state.selectedTab == index);
                return ChoiceChip(
                  labelPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  label: Container(color: Colors.transparent,
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
                    // height: 42.h,
                    child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            (isSelected ? white : black), BlendMode.srcATop),
                        child: choicesList[index]),
                  ),

                  // selected: cryptoProvider.selectedIndex == index,
                  selectedColor: black,
                  backgroundColor: Colors.transparent,
                  selected: isSelected,
                  onSelected: (bool selected) {
                    context.read<OrdersListCubit>().tabSelected(index: index);
                  },
                );
              },
            )));
  }
}

class TabsWidget extends StatelessWidget {
  const TabsWidget({Key? key, required this.state}) : super(key: key);

  final OrdersListState state;

  @override
  Widget build(BuildContext context) {
    switch (state.selectedTab) {
      case 0:
        return const WaitingTab();
      case 1:
        return const DeliveredTab();
      case 2:
        return WarehouseTab();
      default:
        //TODO if there is a state that number go to defult ???
        return Center(
          child: Text("error"),
        );
    }
  }
}
