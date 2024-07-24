import 'package:flutter/material.dart';
import 'package:maids_cc_task/presentation/pages/auth/login/view/login_view.dart';
import 'package:maids_cc_task/presentation/pages/home/view/home_view.dart';
import 'package:maids_cc_task/presentation/pages/splash/view/splash_view.dart';

class AppRoutes {
  static final navKey = GlobalKey<NavigatorState>();
  static const String splashRoute = '/';
  static const String loginRoute = '/loginRoute';
  static const String homeRoute = '/homeRoute';

  static Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) {
          return Builder(
            builder: (BuildContext context) {
              switch (settings.name) {
                case splashRoute:
                  return const SplashView();
                case loginRoute:
                  return const LoginView();
                case homeRoute:
                  return const HomeView();
                default:
                  return const Scaffold(
                    body: Center(
                      child: Text(
                        'Check Named Route',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                  );
              }
            },
          );
        },
        settings: settings);
  }

  static navGo(BuildContext context,
      {required String routeName, Object? arguments}) {
    Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static navOfAll(BuildContext context,
      {required String routeName, Object? arguments}) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
