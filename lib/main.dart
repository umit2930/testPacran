import 'package:dobareh_bloc/presentation/auth/number_page.dart';
import 'package:dobareh_bloc/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      designSize: const Size(360, 790),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Bloc Demo',
          theme: DobareTheme.theme,
          home: const NumberPage(),
        );
      },
    );
  }
}
