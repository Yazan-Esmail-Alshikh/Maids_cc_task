import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_cc_task/presentation/pages/splash/bloc/splash_bloc.dart';
import 'package:maids_cc_task/presentation/resources/routes_manger.dart';
import 'package:maids_cc_task/presentation/resources/string_manger.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(RefreshAuthSession()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is RefreshSessionSuccessState) {
            AppRoutes.navOfAll(context, routeName: AppRoutes.homeRoute);
          }
          if (state is RefreshSessionErrorState) {
            AppRoutes.navOfAll(context, routeName: AppRoutes.loginRoute);
          }
        },
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.maidsCCTask,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  AppStrings.madeWithLoveByYazanAlshikh,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
