import 'package:eksouvan/core/locators/service_locator.dart';
import 'package:eksouvan/core/widgets/not_found.dart';
import 'package:eksouvan/features/appointments/presentation/pages/appointment_page.dart';
import 'package:eksouvan/features/daily-patient/presentation/cubit/daily_patient_cubit.dart';
import 'package:eksouvan/features/daily-patient/presentation/pages/daily_diagnose_patient_page.dart';
import 'package:eksouvan/features/diagnose/presentation/pages/medicine_page..dart';
import 'package:eksouvan/features/diagnose/presentation/pages/summary_page.dart';
import 'package:eksouvan/features/histories/presentation/cubit/history_cubit.dart';
import 'package:eksouvan/features/histories/presentation/pages/history_page.dart';
import 'package:eksouvan/features/histories/presentation/pages/patient_detail_page.dart';
import 'package:eksouvan/features/home/presentation/cubit/home_cubit.dart';
import 'package:eksouvan/features/login/preesentation/cubit/login_cubit.dart';
import 'package:eksouvan/features/login/preesentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/daily-patient/presentation/pages/daily_patient_page.dart';
import '../../features/diagnose/presentation/cubit/diagnose_cubit.dart';
import '../../features/diagnose/presentation/pages/daily_diagnose_detail_page.dart';
import '../../features/diagnose/presentation/pages/daily_diagnose_page.dart';
import '../../features/diagnose/presentation/pages/symptom_page.dart';
import '../../features/diagnose/presentation/widgets/add_diagnose_success_widget.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/register/presentation/cubit/register_patient_cubit.dart';
import '../../features/register/presentation/pages/register_patient_page.dart';
import '../usecases/success_params.dart';
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
  static const String dialyPatient = "/dialyPatient";
  static const String dailyDiagnosePatientPageRoute =
      "/dailyDiagnosePatientPage";
  static const String symptomRoute = "/symptom";
  static const String medicineRoute = "medicine";
  static const String summaryRoute = "summary";
  static const String addDiagnoseSuccessRoute = "addDiagnoseSuccess";
  static const String appointmentRout = "appointment";

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
        final SuccessParams? params = settings.arguments as SuccessParams?;
        return _materialRoute(
            SuccessWidget(
              title: params?.title,
              buttonTile: params?.buttonTitle,
              onPressed: params?.onPressed,
            ),
            providers: []);
      case dailyDiagnoseRoute:
        return _materialRoute(const DialyDiagnosePage(), providers: [
          BlocProvider<DiagnoseCubit>(
            create: (context) => getIt<DiagnoseCubit>()..getAllPatient(),
          )
        ]);
      case dialyDiagnoseDetailRoute:
        final patientId = settings.arguments as String;
        return _materialRoute(const DailyDiagnoseDetailPage(), providers: [
          BlocProvider<DiagnoseCubit>(
            create: (context) => getIt<DiagnoseCubit>()
              ..getCurrentUser()
              ..getPatientById(id: patientId),
          )
        ]);
      case dialyPatient:
        return _materialRoute(const DailyPatientPage(), providers: [
          BlocProvider<DailyPatientCubit>(
            create: (context) => getIt<DailyPatientCubit>()..getDailyPatient(),
          )
        ]);
      case dailyDiagnosePatientPageRoute:
        final String patientId = settings.arguments as String;
        return _materialRoute(const DailyDiagnosePatientPage(), providers: [
          BlocProvider<DailyPatientCubit>(
            create: (context) =>
                getIt<DailyPatientCubit>()..getPatient(patientId: patientId),
          )
        ]);
      case symptomRoute:
        final cubit = settings.arguments as DiagnoseCubit;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<DiagnoseCubit>.value(
            value: cubit..getAllDease(),
            child: const SymptomPage(),
          ),
        );
      case medicineRoute:
        final cubit = settings.arguments as DiagnoseCubit;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<DiagnoseCubit>.value(
            value: cubit..getAllMedicine(),
            child: const MedicinePage(),
          ),
        );
      case summaryRoute:
        final cubit = settings.arguments as DiagnoseCubit;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<DiagnoseCubit>.value(
            value: cubit,
            child: const SummaryPage(),
          ),
        );
      case addDiagnoseSuccessRoute:
        final patientId = settings.arguments as String;
        return _materialRoute(
          AddDiagnoseSuccessWidget(
            patientId: patientId,
          ),
        );
      case appointmentRout:
        return _materialRoute(
          const AppointmentPage(),
        );
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
