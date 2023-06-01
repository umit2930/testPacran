import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconAssistant {
  static Widget backIconButton(Function() onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        "assets/icons/arrow_right.svg",
      ),
    );
  }
}
