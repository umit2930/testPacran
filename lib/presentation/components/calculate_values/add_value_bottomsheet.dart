import 'package:dobareh_bloc/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddValueBottomSheet extends StatefulWidget {
   const AddValueBottomSheet({Key? key,required this.title}) : super(key: key);

  final String title;

  @override
  State<AddValueBottomSheet> createState() => _AddValueBottomSheetState();
}

class _AddValueBottomSheetState extends State<AddValueBottomSheet> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
        width: 360.w,
        // height: 264.h,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Wrap(
            children: [
              Text("لطفا مقادیر فروشنده برای ${widget.title} را وارد کنید.",
                  style: textTheme.bodyLarge?.copyWith(
                    color: natural2,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: Text(
                  "مقدار پسماند",
                  style: textTheme.bodyMedium?.copyWith(color: natural2),
                ),
              ),
              SizedBox(
                height: 56.h,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(right: 16.w, top: 14.h, bottom: 14.h),
                      fillColor: white,
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryTint2),
                          borderRadius: BorderRadius.circular(16.r)),
                      hintText: "مقدار پسماند را وارد کنید.",
                      hintStyle:
                          textTheme.bodyLarge?.copyWith(color: natural5)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: SizedBox(
                  height: 48.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          double.parse(
                              _controller.text == "" ? "0" : _controller.text));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r))),
                    child: const Text("ثبت"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
