import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class MaterialItem extends StatelessWidget {
  const MaterialItem(
      {Key? key, required this.title, required this.unit, required this.weight})
      : super(key: key);

  final String title;
  final String unit;
  final String weight;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Text(title,
                  style: textTheme.bodyMedium?.copyWith(color: natural2)),
            ),
            Text(weight,
                style: textTheme.titleSmall?.copyWith(color: natural2)),
            SizedBox(
              width: 8.w,
            ),
            Text(unit, style: textTheme.bodyMedium?.copyWith(color: natural6)),
          ],
        )
      ]),
    );
  }
}
