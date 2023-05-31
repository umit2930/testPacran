import 'package:dobareh_bloc/business_logic/auth/auth/authentication_cubit.dart';
import 'package:dobareh_bloc/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child:  FilledButton(onPressed: () async{
              await context.read<AuthRepository>().saveToken("");
              await context.read<AuthRepository>().getToken();
              context.read<AuthenticationCubit>().userChanged();

            }, child: Text("Logout"))));
  }
}
