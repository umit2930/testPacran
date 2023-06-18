import 'package:dobareh_bloc/presentation/pages/home_page.dart';
import 'package:get/get.dart';

void notificationRouter(String route) {
  switch (route) {
    case "/home_screen":
      Get.offAll(HomePage.router());
  }
}
