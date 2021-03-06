import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/dropdown_item.dart';
import '../../../histories/domain/usecases/get_all_patient_usecase.dart';
import '../../../histories/domain/usecases/get_patient_usecase.dart';
import '../../../home/domain/usecases/get_current_user_usecase.dart';
import '../../../register/domain/entity/patient.dart';
import '../../domain/useases/add_diagnose_usecase.dart';
import 'diagnose_state.dart';

@injectable
class DiagnoseCubit extends Cubit<DiagnoseState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  final AddDiagnoseUsecase addDiagnoseUsecase;
  final GetCUrrentUserUsecase getCUrrentUserUsecase;
  final GetPatientUsecase getPatientUsecase;
  final Uuid uuid;
  DiagnoseCubit(this.getAllPatientUsecase, this.addDiagnoseUsecase,
      this.getCUrrentUserUsecase, this.getPatientUsecase, this.uuid)
      : super(const DiagnoseState());
  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final DateTime currentDate = DateTime.now();

  String? currentUserId;
  List<DropdwonItems> genderList = [
    DropdwonItems(id: 1, name: 'Meal'),
    DropdwonItems(id: 2, name: "Female")
  ];
  Future<void> getAllPatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final results = await getAllPatientUsecase(NoParams());
    results.fold((error) {
      emit(state.copyWith(dataStatus: DataStatus.failure, error: error.msg));
    }, (data) {
      emit(state.copyWith(dataStatus: DataStatus.success, listPatient: data));
    });
  }

  Future<void> getCurrentUser() async {
    final result = await getCUrrentUserUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (data) {
      currentUserId = data;
    });
  }

  Future<void> getPatientById({required String id}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getPatientUsecase(GetPatientParams(patientId: id));
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (patient) {
      emit(state.copyWith(dataStatus: DataStatus.success, patient: patient));
    });
  }

  Future<void> addPatientDiagnose({Patient? patient}) async {
    if (formKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      Map<String, dynamic> formValue = {};
      final String diagnoseId = uuid.v4();
      Map<String, dynamic> formData = {};
      formData.addAll({
        FieldKeys.kDiagnoseDate: currentDate,
        FieldKeys.kUserId: currentUserId,
        FieldKeys.kPatientId: patient?.patientId,
        FieldKeys.kDiagnoseId: diagnoseId,
        ...formKey.currentState?.value ?? {}
      });
      var fromConvert = ConvertDatas.convertMapData(mapData: formData);
      DiagnoseModel diagnose = DiagnoseModel.fromJson(fromConvert);
      formValue.addAll({
        FieldKeys.kLastUpdate: currentDate,
        FieldKeys.kDiagnoses: FieldValue.arrayUnion([diagnose.toJson()]),
      });
      final result = await addDiagnoseUsecase(AddDiagnoseParams(
          patientId: patient?.patientId ?? '', data: formValue));
      result.fold((error) {
        emit(state.copyWith(dataStatus: DataStatus.failure, error: error.msg));
      }, (success) {
        emit(state.copyWith(dataStatus: DataStatus.success));
        AppNavigator.navigateTo(AppRoute.successRoute);
      });
    } else {
      print("validate form");
    }
  }
}
