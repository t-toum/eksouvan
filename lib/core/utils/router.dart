import 'package:eksouvan/core/widgets/not_found.dart';
import 'package:eksouvan/features/login/preesentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/pages/home_page.dart';

class AppRoute {
  static const String homeRoute = "/";
  static const String detailRoute = "/detail";
  static const String loginRoute = "/login";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _materialRoute(
          const MyHomePage(),
          // providers: [

          // ]
        );
      case loginRoute:
        return _materialRoute(LoginPage());
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
