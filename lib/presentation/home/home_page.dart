import 'package:dobareh_bloc/business_logic/auth/auth/authentication_cubit.dart';
import 'package:dobareh_bloc/business_logic/home/home_cubit.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';
import 'package:dobareh_bloc/data/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget router() {
    return BlocProvider(
      create: (BuildContext context) {
        return HomeCubit(homeRepository: context.read<HomeRepository>());
      },
      child: const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.homeStatus == HomeStatus.initial) {
          context.read<HomeCubit>().getHome();
          return const CircularProgressIndicator();
        } else if (state.homeStatus == HomeStatus.loading) {
          return const CircularProgressIndicator();
        } else {
          return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.homeResponse?.user?.firstName ?? "میهمان"),
                  FilledButton(
                      onPressed: () async {
                        //TODO don't use repository in presentation layer
                        var authRepository = context.read<AuthRepository>();
                        var authCubit = context.read<AuthenticationCubit>();
                        await authRepository.saveToken("");
                        await authRepository.getToken();
                        authCubit.userChanged();
                      },
                      child: const Text("Logout")),
                ],
              ));
        }
      },
    ));
  }
}
