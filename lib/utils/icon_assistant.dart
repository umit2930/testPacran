import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconAssistant {
  static Widget backIconButton(Function() onPressed) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: SvgPicture.asset(
        "assets/icons/arrow_right.svg",
      ),
    );

  }  static Widget forwardIconButton(Function()? onPressed) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: SvgPicture.asset(
        "assets/icons/arrow_left.svg",
      ),
    );
  }

  static Widget menuIconButton(Function() onPressed) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: SvgPicture.asset(
        "assets/icons/profile.svg",
      ),
    );
  }

  static Widget notificationIconButton(Function() onPressed) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: SvgPicture.asset(
        "assets/icons/notification.svg",
      ),
    );
  }

  static Widget moreIconButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: null,
      icon: SvgPicture.asset(
        "assets/icons/more.svg",
      ),
    );
  }
}
