import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:eksouvan/features/register/data/model/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/dropdown_item.dart';
import '../../../histories/domain/usecases/get_all_patient_usecase.dart';
import '../../../home/domain/usecases/get_current_user_usecase.dart';
import '../../../register/domain/entity/patient.dart';
import '../../domain/useases/add_diagnose_usecase.dart';
import 'diagnose_state.dart';

@injectable
class DiagnoseCubit extends Cubit<DiagnoseState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  final AddDiagnoseUsecase addDiagnoseUsecase;
  final GetCUrrentUserUsecase getCUrrentUserUsecase;
  DiagnoseCubit(this.getAllPatientUsecase, this.addDiagnoseUsecase,
      this.getCUrrentUserUsecase)
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
    results.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (data) {
      emit(state.copyWith(dataStatus: DataStatus.success, listPatient: data));
    });
  }

  Future<void> getCurrentUser() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getCUrrentUserUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (data) {
      currentUserId = data;
      emit(state.copyWith(dataStatus: DataStatus.success));
    });
  }

  Future<void> addPatientDiagnose({Patient? patient}) async {
    if (formKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      Map<String, dynamic> formData = {};
      formData.addAll({
        FieldKeys.kDiagnoseDate: currentDate,
        FieldKeys.kUserId: currentUserId,
        FieldKeys.kPatientId: patient?.patientId,
        ...formKey.currentState?.value ?? {}
      });
      Map<String, dynamic> formValue =
          ConvertDatas.convertMapData(mapData: formData);
      DiagnoseModel diagnose = DiagnoseModel.fromJson(formValue);
      final result =
          await addDiagnoseUsecase(AddDiagnoseParams(diagnoseModel: diagnose));
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
