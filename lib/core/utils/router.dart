import 'package:eksouvan/core/locators/service_locator.dart';
import 'package:eksouvan/core/widgets/not_found.dart';
import 'package:eksouvan/features/histories/presentation/pages/history_page.dart';
import 'package:eksouvan/features/login/preesentation/cubit/login_cubit.dart';
import 'package:eksouvan/features/login/preesentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/register_patient/presentation/pages/register_patient_page.dart';

class AppRoute {
  static const String homeRoute = "/";
  static const String detailRoute = "/detail";
  static const String loginRoute = "/login";
  static const String registerPatientRoute = "/registerPatient";
  static const String historyRoute = "/history";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _materialRoute(
          const HomePage(),
          // providers: [

          // ]
        );
      case loginRoute:
        return _materialRoute(LoginPage(), providers: [
          BlocProvider<LoginCubit>(
            create: (context) => getIt<LoginCubit>(),
          )
        ]);
      case registerPatientRoute:
        return _materialRoute(const RegisterPatientPage());
      case historyRoute:
        return _materialRoute(const HistoryPage());
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFound(),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget screen,
      {List<BlocProvider> providers = const []}) {
    return MaterialPageRoute(
        builder: (context) => providers.isNotEmpty
            ? MultiBlocProvider(providers: providers, child: screen)
            : screen);
  }
}
