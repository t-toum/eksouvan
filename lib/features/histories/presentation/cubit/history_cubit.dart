import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/appointments/domain/entities/appointment.dart';
import 'package:eksouvan/features/histories/domain/usecases/get_all_patient_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../appointments/domain/usecases/get_all_appointment_usecase.dart';
import '../../../diagnose/domain/entity/diagnose.dart';
import '../../../register/domain/entity/patient.dart';
import '../../domain/usecases/get_all_daignose_usecase.dart';
import '../../domain/usecases/get_patient_usecase.dart';
import 'history_state..dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

@injectable
class HistoryCubit extends Cubit<HistoryState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  final GetPatientUsecase getPatientUsecase;
  final GetAllDiagnoseUsecase getAllDiagnoseUsecase;
  final GetAllAppointmentUsecase getAllAppointmentUsecase;
  HistoryCubit(
    this.getAllPatientUsecase,
    this.getPatientUsecase,
    this.getAllDiagnoseUsecase,
    this.getAllAppointmentUsecase,
  ) : super(const HistoryState());
  TextEditingController searchController = TextEditingController();
//Field
  List<Diagnose>? listDiagnose;
  List<Appointment>? listAppointment;
  Future<void> getAllPatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getAllPatientUsecase(NoParams());
    result.fold(
      (error) => emit(
          state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
      (success) {
        searchController.addListener(() {
          if (searchController.text.isNotEmpty) {
            List<Patient> newList = success
                .where(
                  (patient) =>
                      patient.firstname!
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase()) ||
                      patient.lastname!.toLowerCase().contains(
                            searchController.text.toLowerCase(),
                          ),
                )
                .toList();
            emit(state.copyWith(
                dataStatus: DataStatus.success, listPatient: newList));
          } else {
            emit(state.copyWith(
                dataStatus: DataStatus.success, listPatient: success));
          }
        });
        emit(state.copyWith(
            dataStatus: DataStatus.success, listPatient: success));
      },
    );
  }

  Future<void> getPatient({required String patientId}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    await getAllDiagnose(patientId: patientId);
    await getAppointment(patientId: patientId);
    final result =
        await getPatientUsecase(GetPatientParams(patientId: patientId));
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      emit(state.copyWith(
        dataStatus: DataStatus.success,
        patient: success,
      ));
    });
  }

  Future<void> getAllDiagnose({required String patientId}) async {
    final result = await getAllDiagnoseUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      listDiagnose = success.where((el) => el.patientId == patientId).toList();
    });
  }

  Future<void> getAppointment({required String patientId}) async {
    final result = await getAllAppointmentUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      listAppointment =
          success.where((el) => el.patientId == patientId).toList();
    });
  }

  Future<void> printDoc() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          ); // Center
        },
      ),
    );
  }
}
