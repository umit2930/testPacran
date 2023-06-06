import 'package:dobareh_bloc/presentation/pages/home_page.dart';
import 'package:dobareh_bloc/presentation/pages/number_page.dart';
import 'package:dobareh_bloc/presentation/pages/splash_page.dart';
import 'package:dobareh_bloc/utils/dependency_injection.dart';
import 'package:dobareh_bloc/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'business_logic/auth/authentication_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.provideAuth();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AuthenticationCubit();
      },
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        designSize: const Size(360, 790),
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // navigatorKey: _navigatorKey,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('fa'),
            ],
            locale: const Locale('fa'),
            title: 'Bloc Demo',
            theme: DobareTheme.theme,
            builder: (context, child) {
              return BlocListener<AuthenticationCubit, AuthenticationState>(
                listener: (context, state)  {
                  switch (state.authenticationStatus) {
                    case AuthenticationStatus.initial:
                      context.read<AuthenticationCubit>().authRequested();
                      break;
                    case AuthenticationStatus.authenticated:

                      ///when authenticated, user token will not null
                      //TODO change the logic to user token be not nullable?
                      var userToken = state.userToken!;

                      DependencyInjection.provideUserToken(userToken);
                      DependencyInjection.provideHome();
                      DependencyInjection.provideOrder();

                      Get.offAll(() => HomePage.router());
                      break;
                    case AuthenticationStatus.unauthenticated:
                      //TODO change to offALl.
                      Get.off(() => NumberPage.router());
                      break;
                  }
                },
                child: child,
              );
            },
            onGenerateRoute: (_) => MaterialPageRoute<void>(builder: (_) {
              context.read<AuthenticationCubit>().authRequested();
              return const SplashPage();
            }),
          );
        },
      ),
    );
  }
}
