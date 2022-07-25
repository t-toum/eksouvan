import 'package:eksouvan/core/locators/service_locator.dart';
import 'package:eksouvan/core/widgets/not_found.dart';
import 'package:eksouvan/features/histories/presentation/cubit/history_cubit.dart';
import 'package:eksouvan/features/histories/presentation/pages/history_page.dart';
import 'package:eksouvan/features/histories/presentation/pages/patient_detail_page.dart';
import 'package:eksouvan/features/home/presentation/cubit/home_cubit.dart';
import 'package:eksouvan/features/login/preesentation/cubit/login_cubit.dart';
import 'package:eksouvan/features/login/preesentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/diagnose/presentation/cubit/diagnose_cubit.dart';
import '../../features/diagnose/presentation/pages/daily_diagnose_detail_page.dart';
import '../../features/diagnose/presentation/pages/daily_diagnose_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/register/domain/entity/patient.dart';
import '../../features/register/presentation/cubit/register_patient_cubit.dart';
import '../../features/register/presentation/pages/register_patient_page.dart';
import '../widgets/success_widget.dart';

class AppRoute {
  static const String homeRoute = "/";
  static const String detailRoute = "/detail";
  static const String loginRoute = "/login";
  static const String registerPatientRoute = "/registerPatient";
  static const String historyRoute = "/history";
  static const String patientDetailRoute = "/patientDetal";
  static const String successRoute = "/success";
  static const String dailyDiagnoseRoute = "/dialyDiagnose";
  static const String dialyDiagnoseDetailRoute = "/dialyDiagnoseDetail";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _materialRoute(const HomePage(), providers: [
          BlocProvider<HomeCubit>(
            create: (context) => getIt<HomeCubit>(),
          )
        ]);
      case loginRoute:
        return _materialRoute(LoginPage(), providers: [
          BlocProvider<LoginCubit>(
            create: (context) => getIt<LoginCubit>()..initialLogin(),
          )
        ]);
      case registerPatientRoute:
        return _materialRoute(const RegisterPatientPage(), providers: [
          BlocProvider<RegisterPatientCubit>(
            create: (context) =>
                getIt<RegisterPatientCubit>()..getCurrentUser(),
          )
        ]);
      case historyRoute:
        return _materialRoute(const HistoryPage(), providers: [
          BlocProvider<HistoryCubit>(
            create: (context) => getIt<HistoryCubit>()..getAllPatient(),
          )
        ]);
      case patientDetailRoute:
        return _materialRoute(const PatientDetailPage(), providers: [
          BlocProvider<HistoryCubit>(
            create: (context) => getIt<HistoryCubit>()
              ..getPatient(patientId: settings.arguments as String),
          )
        ]);
      case successRoute:
        final String? title = settings.arguments as String?;
        return _materialRoute(SuccessWidget(title: title), providers: []);
      case dailyDiagnoseRoute:
        return _materialRoute(const DialyDiagnosePage(), providers: [
          BlocProvider<DiagnoseCubit>(
            create: (context) => getIt<DiagnoseCubit>()..getAllPatient(),
          )
        ]);
      case dialyDiagnoseDetailRoute:
        final patient = settings.arguments as Patient?;
        return _materialRoute(
            DailyDiagnoseDetailPage(
              patient: patient,
            ),
            providers: [
              BlocProvider<DiagnoseCubit>(
                create: (context) => getIt<DiagnoseCubit>()..getCurrentUser(),
              )
            ]);
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
