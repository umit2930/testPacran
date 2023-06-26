import 'package:dobareh_bloc/business_logic/order/order_details_cubit.dart';
import 'package:dobareh_bloc/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/colors.dart';

class CommunicationWidget extends StatelessWidget {
  const CommunicationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*Container(
      width: 69.w,
      height: 56.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: secondaryTint2,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            var number = context
                .read<OrderDetailsCubit>()
                .state
                .orderResponse
                ?.order
                ?.deliveryPersonNumber;
            Uri phoneNo = Uri.parse('tel:$number');
            launchUrl(phoneNo);
          },
          child: SvgPicture.asset(
            "assets/icons/call.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );*/
      Row(
        children: [
          Container(
            width: 69.w,
            height: 56.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: secondaryTint2,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                var number = context
                    .read<OrderDetailsCubit>()
                    .state
                    .orderResponse
                    ?.order
                    ?.deliveryPersonNumber;
                Uri phoneNo = Uri.parse('tel:$number');
                launchUrl(phoneNo);
              },
              child: SvgPicture.asset(
                "assets/icons/call.svg",
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
         SizedBox(width: 16.w),
          Container(
            width: 69.w,
            height: 56.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: secondaryTint2,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.showToast(message: "به زودی", messageType: MessageType.info);
                },
                child: SvgPicture.asset(
                  "assets/icons/message.svg",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),

          ),
        ],
      );
  }
}
