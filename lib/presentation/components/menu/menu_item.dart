import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem(
      {Key? key,
      required this.svgAsset,
      required this.text,
      required this.onTap})
      : super(key: key);

  final String svgAsset;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(8)),
                    child: SvgPicture.asset(
                      svgAsset,
                      fit: BoxFit.scaleDown,
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Text(
                    text,
                    style: textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
