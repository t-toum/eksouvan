import 'package:eksouvan/core/models/deases_model.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';
import 'package:eksouvan/features/register_patient/domain/entity/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';

import '../../../histories/domain/usecases/get_all_patient_usecase.dart';
import '../../domain/useases/add_diagnose_usecase.dart';
import 'diagnose_state.dart';

@injectable
class DiagnoseCubit extends Cubit<DiagnoseState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  final AddDiagnoseUsecase addDiagnoseUsecase;
  DiagnoseCubit(this.getAllPatientUsecase, this.addDiagnoseUsecase)
      : super(const DiagnoseState());
  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final DateTime currentDate = DateTime.now();

  Future<void> getAllPatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final results = await getAllPatientUsecase(NoParams());
    results.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (data) {
      emit(state.copyWith(dataStatus: DataStatus.success, listPatient: data));
    });
  }

  Future<void> addPatientDiagnose({Patient? patient}) async {
    if (formKey.currentState!.saveAndValidate()) {
      Map<String, dynamic> formValue = ConvertDatas.convertMapData(
          mapData: formKey.currentState?.value ?? {});
      patient?.updateDate = DateTime.now();
      DiagnoseModel deases = DiagnoseModel.fromJson(formValue);
      PatientModel patientModel = patient as PatientModel;
      patientModel.diagnoses?.add(deases);
      // final result = await addDiagnoseUsecase(AddDiagnoseParams(
      //     doc: patient.patientId ?? '', patientModel: patientModel));
    } else {
      print("validate form");
    }
  }
}
