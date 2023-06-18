import 'package:dobareh_bloc/business_logic/notifications/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../utils/colors.dart';
import '../../utils/icon_assistant.dart';
import '../components/general/loading_widget.dart';
import '../components/general/retry_widget.dart';
import '../components/notifications/notification_item.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  static Widget router() {
    return BlocProvider(
      create: (context) => NotificationsCubit(),
      child: const NotificationPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.h),
        child: const NotificationsAppbar(),
      ),
      body: const NotificationsBody(),
    );
  }
}

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (BuildContext context, state) {
        switch (state.notificationsStatus) {
          case NotificationsStatus.initial:
            context.read<NotificationsCubit>().notificationsRequested();
            return const LoadingWidget();
          case NotificationsStatus.loading:
            return const LoadingWidget();
          case NotificationsStatus.failure:
            return FailureWidget(onRetryPressed: () {});
          case NotificationsStatus.success:
            var notifications = state.notificationsResponse!.notification;
            /*var gregorianDate =
                DateFormat('yyyy-MM-dd').parse(inputString);*/
            return Column(
              children: [
                ///content
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (BuildContext context, int index) {
                      var item = notifications?.elementAt(index);
                      var date = DateTime.parse(item?.createdAt ?? "");
                      var jalaliDate = Jalali.fromDateTime(date);

                      return NotificationItem(
                        title: item?.title ?? "عنوان",
                        body: item?.body ?? "متن اعلان",
                        createdAt:
                            "${jalaliDate.formatShortDate()} - ${TimeOfDay.fromDateTime(date).persianFormat(context)}",
                        location: item?.location ?? "/home_screen",
                      );
                    },
                    itemCount: notifications?.length,
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}

class NotificationsAppbar extends StatelessWidget {
  const NotificationsAppbar({
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
              child: Text("اعلان ها",
                  style: textTheme.bodySmall?.copyWith(color: secondary)),
            ),
          ],
        ),
      ),
    );
  }
}
