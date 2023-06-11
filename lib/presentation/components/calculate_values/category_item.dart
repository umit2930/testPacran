import 'package:dobareh_bloc/business_logic/order/calculate_values_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/model/calculate_values/CalculateValuesBody.dart';
import '../../../utils/colors.dart';
import 'add_value_bottomsheet.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return BlocBuilder<CalculateValuesCubit, CalculateValuesState>(
      buildWhen: (previousState, newState) {
        var category = previousState.categoriesResponse!.materialCategories!
            .elementAt(index);
        var rebuild = previousState.addedValues[category]?.value !=
            newState.addedValues[category]?.value;

        return rebuild;
      },
      builder: (BuildContext context, state) {
        var category =
            state.categoriesResponse!.materialCategories!.elementAt(index);
        var amount = state.addedValues[category]?.value;
        var cubit = context.read<CalculateValuesCubit>();
        return Container(
          height: 60.h,
          margin: EdgeInsets.only(top: 16.h),
          decoration: boxDecoration,
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                showModalBottomSheet<double>(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return AddValueBottomSheet(
                        title: category.title ?? "پسماند",
                      );
                    }).then((value) {
                      print(value);
                  if (value != null) {
                    ///delete
                    if (value == 0.0) {
                      cubit.valueDeleted(category);
                    } else {
                      ///add
                      if (amount == null) {
                        cubit.valueAdded(category,
                            Items(material: category.id, value: value));
                      } else {
                        ///update
                        cubit.valueUpdated(category,
                            Items(material: category.id, value: value));
                      }
                    }
                  }
                });
              },
              child: Row(
                children: [
                  Container(
                    color: amount == null ? white : primary,
                    height: double.infinity,
                    width: 6.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10.w,
                    ),
                    child: Text(
                      category.title ?? "نام دسته بندی",
                      style: textTheme.titleSmall?.copyWith(
                          color: amount == null ? natural2 : primary),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(amount == null ? "" : "$amount",
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleLarge?.copyWith(color: natural2)),
                  ),
                  Expanded(
                    child: Text(
                      amount == null ? "" : " کیلو",
                      style: textTheme.bodyMedium?.copyWith(color: natural6),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: amount == null
                        ? IconButton(
                            iconSize: 50.h,
                            icon: SvgPicture.asset("assets/icons/add.svg"),
                            onPressed: null,
                            padding: EdgeInsets.zero,
                          )
                        : IconButton(
                            iconSize: 50.h,
                            onPressed: null,
                            icon: SvgPicture.asset("assets/icons/edit.svg"),
                            padding: EdgeInsets.zero,
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
