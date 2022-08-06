import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/features/appointments/data/models/appointment_model.dart';
import 'package:eksouvan/features/appointments/domain/usecases/add_appointment.dart';
import 'package:eksouvan/features/histories/domain/usecases/get_all_patient_usecase.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/appointment.dart';
import '../../domain/usecases/get_all_appointment_usecase.dart';
import 'appointment_state.dart';

@injectable
class AppointmentCubit extends Cubit<AppointmentState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  final AddApointmentUsecase addApointmentUsecase;
  final GetAllAppointmentUsecase getAllAppointmentUsecase;
  AppointmentCubit(this.getAllPatientUsecase, this.addApointmentUsecase,
      this.getAllAppointmentUsecase)
      : super(const AppointmentState());
  //Field
  final formKey = GlobalKey<FormBuilderState>();
  String? selectedPatientId;
  List<Patient>? listPatient;

  Future<void> getAppointment() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final results = await getAllAppointmentUsecase(NoParams());
    results.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      List<Appointment> fitterAppointment = success.where((appointment) {
        return ConvertDatas.converDateFormat(DateTime.now()).compareTo(
                ConvertDatas.converDateFormat(appointment.dueDate!)) <=
            0;
      }).toList();
      emit(state.copyWith(
          dataStatus: DataStatus.success, listAppointment: fitterAppointment));
    });
  }

  Future<void> getAllPatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getAllPatientUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      listPatient = success;
      emit(
          state.copyWith(dataStatus: DataStatus.success, listPatient: success));
    });
  }

  Future<void> addAppointment() async {
    if (formKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      Map<String, dynamic> formValue = ConvertDatas.convertMapData(
          mapData: formKey.currentState?.value ?? {});
      formValue.addAll({FieldKeys.kAppointmentDate: DateTime.now().toString()});
      AppointmentModel data = AppointmentModel.formJson(formValue);
      final results = await addApointmentUsecase(AppointmentParams(data: data));
      results.fold(
          (error) => emit(
              state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
          (success) {
        emit(state.copyWith(dataStatus: DataStatus.saveAppointmentSuccess));
      });
    }
  }

  void onChangeValue({String? value}) {
    selectedPatientId = value;
  }

  String getPatient({String? patientId}) {
    if (patientId != null) {
      final data = listPatient?.where((el) => el.patientId == patientId).first;
      return "${data?.firstname} ${data?.lastname}";
    } else {
      return "";
    }
  }
}
