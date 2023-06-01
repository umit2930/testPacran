import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color primary = Color.fromRGBO(99, 180, 80, 1);
const Color secondary = Color.fromRGBO(5, 59, 89, 1);
const Color secondaryTint1 = Color.fromRGBO(105, 137, 155, 1);
const Color secondaryTint2 = Color.fromRGBO(232, 237, 240, 1);
const Color primaryTint3 = Color.fromRGBO(222, 240, 220, 1);
const Color primaryShade2 = Color.fromRGBO(39, 72, 32, 1);

const Color error = Color.fromRGBO(222, 57, 57, 1);
const Color success = Color.fromRGBO(9, 142, 9, 1);
const Color warning = Color.fromRGBO(255, 193, 7, 1);

const Color yellow = Color.fromRGBO(254, 223, 137, 1);

const Color black = Color.fromRGBO(28, 27, 31, 1);
const Color natural1 = Color.fromRGBO(49, 48, 51, 1);
const Color natural2 = Color.fromRGBO(72, 70, 73, 1);
const Color natural3 = Color.fromRGBO(96, 93, 98, 1);
const Color natural4 = Color.fromRGBO(120, 117, 121, 1);
const Color natural5 = Color.fromRGBO(147, 144, 148, 1);
const Color natural6 = Color.fromRGBO(174, 170, 174, 1);
const Color natural7 = Color.fromRGBO(201, 197, 202, 1);
const Color natural8 = Color.fromRGBO(238, 238, 238, 1);
const Color natural9 = Color.fromRGBO(250, 250, 250, 1);
const Color white = Color.fromRGBO(255, 255, 255, 1);

const Color background = Color.fromRGBO(244, 245, 247, 1);

var boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12.r),
  boxShadow: const [
    BoxShadow(color: Colors.black87, blurRadius: 8, spreadRadius: -8),
  ],
);

var topRoundedBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
  boxShadow: const [
    BoxShadow(color: Colors.black87, blurRadius: 12, spreadRadius: -8),
  ],
);

const double appbarSize = 66;
