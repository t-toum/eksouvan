import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/histories/domain/usecases/get_all_patient_usecase.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../histories/domain/usecases/get_patient_usecase.dart';
import 'daily_patient_state.dart';

@injectable
class DailyPatientCubit extends Cubit<DailyPatientState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  final GetPatientUsecase getPatientUsecase;
  DailyPatientCubit(this.getAllPatientUsecase, this.getPatientUsecase)
      : super(const DailyPatientState());
  final TextEditingController searchTextController = TextEditingController();
  Future<void> getDailyPatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final results = await getAllPatientUsecase(NoParams());
    results.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (res) {
      List<Patient>? listPatient = res.where((patient) {
        return DateFormatPattern.kShortDateFormat.format(patient.lastUpdate!) ==
                DateFormatPattern.kShortDateFormat.format(DateTime.now()) &&
            (patient.diagnoses != null && patient.diagnoses!.isNotEmpty);
      }).toList();
      emit(state.copyWith(
          dataStatus: DataStatus.success, listPatient: listPatient));
    });
  }

  Future<void> getPatient({required String patientId}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result =
        await getPatientUsecase(GetPatientParams(patientId: patientId));
    result.fold(
        (error) => emit(
            state..copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (res) {
      emit(state.copyWith(dataStatus: DataStatus.success, patient: res));
    });
  }
}
