import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/histories/domain/usecases/get_all_patient_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';

import 'appointment_state.dart';

@injectable
class AppointmentCubit extends Cubit<AppointmentState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  AppointmentCubit(this.getAllPatientUsecase) : super(const AppointmentState());
  //Field
  String? selectedPatientId;
  final formKey = GlobalKey<FormBuilderState>();

  Future<void> getAppointment() async {}
  Future<void> getAllPatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getAllPatientUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      emit(
          state.copyWith(dataStatus: DataStatus.success, listPatient: success));
    });
  }

  Future<void> addAppointment() async {
    if (formKey.currentState!.saveAndValidate()) {
      print(formKey.currentState);
    }
  }

  void onChangeValue({String? value}) {
    selectedPatientId = value;
  }
}
