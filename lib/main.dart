import 'package:dobareh_bloc/business_logic/auth/auth/authentication_cubit.dart';
import 'package:dobareh_bloc/data/data_provider/local/app_shared_preferences.dart';
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
  // var pref = AppSharedPreferences();
  //TODO getToken() is set repository token key
  var repository = AuthRepository(AuthApiProvider(), AppSharedPreferences());
  await repository.getToken();
  runApp(App(authRepository: repository));
}

class App extends StatelessWidget {
  const App({Key? key, required this.authRepository}) : super(key: key);
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (context) {
          return AuthenticationCubit(authRepository: authRepository);
        },
        child: ScreenUtilInit(
          useInheritedMediaQuery: true,
          minTextAdapt: true,
          designSize: const Size(360, 790),
          builder: (BuildContext context, Widget? child) {
            return GetMaterialApp(
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
                    if (state.authenticationStatus ==
                        AuthenticationStatus.authenticated) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Get.offAll(() => RepositoryProvider(
                              create: (context) => HomeRepository(
                                  HomeApiProvider(state.userToken)),
                              child: HomePage.router(),
                            ));
                      });
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Get.off(() => NumberPage.router());
                      });
                    }
                  },
                  child: child,
                );
              },
              onGenerateRoute: (_) => MaterialPageRoute<void>(builder: (_) {
                context.read<AuthenticationCubit>().userChanged();
                return const SplashPage();
              }),
            );
          },
        ),
      ),
    );
  }
}
