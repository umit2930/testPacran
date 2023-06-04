import 'package:dobareh_bloc/business_logic/auth/auth/authentication_cubit.dart';
import 'package:dobareh_bloc/data/data_provider/local/auth_shared_preferences.dart';
import 'package:dobareh_bloc/data/data_provider/remote/auth/auth_api_provider.dart';
import 'package:dobareh_bloc/data/data_provider/remote/order/home_api_provider.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';
import 'package:dobareh_bloc/presentation/auth/number_page/number_page.dart';
import 'package:dobareh_bloc/presentation/home/home_page.dart';
import 'package:dobareh_bloc/presentation/splash_page.dart';
import 'package:dobareh_bloc/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'data/repository/home_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.portraitUp]);
  var repository =
      AuthRepository(AuthApiProvider(), await AuthSharedPreferences.getInstance());
  Get.put(repository);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: Get.find<AuthRepository>(),
      child: BlocProvider(
        create: (context) {
          return AuthenticationCubit(
              authRepository: Get.find<AuthRepository>());
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
                  listener: (context, state) {
                    switch (state.authenticationStatus) {
                      case AuthenticationStatus.initial:
                        context.read<AuthenticationCubit>().authRequested();
                        break;
                      case AuthenticationStatus.authenticated:

                      ///when authenticated, user token will not null
                      //TODO change the logic to user token be not nullable?
                        var userToken = state.userToken!;
                        Get.offAll(() => RepositoryProvider(
                          create: (context) =>
                              HomeRepository(HomeApiProvider(userToken)),
                          child: HomePage.router(),
                        ));
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
      ),
    );
  }
}
