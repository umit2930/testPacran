part of 'home_page.dart';

class SummeryWidget extends StatelessWidget {
  const SummeryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final HomeResponse model = context.read<HomeCubit>().state.homeResponse!;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: boxDecoration,
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "خلاصه گزارش  ",
                    style: textTheme.titleSmall?.copyWith(color: natural3)),
                TextSpan(
                    text:
                        "${model.today!.persianDayOfWeek} ${model.today!.dayOfMonthInJalali} ${model.today!.persianMonth}",
                    style: textTheme.bodySmall?.copyWith(color: natural4)),
              ])),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "کل سفارشات",
                            style:
                                textTheme.bodySmall?.copyWith(color: natural4)),
                        TextSpan(
                            text: "\n ${model.todayOrdersCount}",
                            style: textTheme.titleSmall
                                ?.copyWith(color: natural2)),
                        TextSpan(
                            text: " عدد ",
                            style:
                                textTheme.bodySmall?.copyWith(color: natural6)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 37.h,
                  width: 1.w,
                  color: natural8,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "تحویل شده",
                              style: textTheme.bodySmall
                                  ?.copyWith(color: natural4)),
                          TextSpan(
                              text: "\n ${model.todayDeliveredCount}",
                              style: textTheme.titleSmall
                                  ?.copyWith(color: natural2)),
                          TextSpan(
                              text: " عدد ",
                              style: textTheme.bodySmall
                                  ?.copyWith(color: natural6)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
