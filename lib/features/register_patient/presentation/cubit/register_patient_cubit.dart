import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';
import 'package:eksouvan/features/register_patient/domain/usecases/add_new_patient_usecase.dart';
import 'package:eksouvan/features/register_patient/presentation/cubit/register_patient_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/usecases/get_current_user_usecase.dart';

@injectable
class RegisterPatientCubit extends Cubit<RegisterPatientState> {
  final AddNewPatientUsecase addNewPatientUsecase;
  final GetCUrrentUserUsecase getCUrrentUserUsecase;
  RegisterPatientCubit(this.getCUrrentUserUsecase, this.addNewPatientUsecase)
      : super(const RegisterPatientState());
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameController = TextEditingController();

  String? currentUserId;

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

  Future<void> addNewPatient() async {
    if (formKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      Map<String, dynamic> formValue = {};
      formValue.addAll({
        "user": currentUserId,
      });
      formKey.currentState?.value.forEach((key, value) {
        formValue[key] = value;
        if (value is DateTime) {
          formValue[key] = value.toString();
        }
      });
      PatientModel patientModel = PatientModel.fromJson(formValue);
      final result = await addNewPatientUsecase(
          AddNewPatientParams(patientModel: patientModel));
      result.fold((error) {
        emit(state.copyWith(dataStatus: DataStatus.failure, error: error.msg));
      }, (success) {
        emit(
            state.copyWith(dataStatus: DataStatus.success, patientId: success));
        AppNavigator.navigateTo(AppRoute.successRoute,
            params: tr("kAddNewPatientSuccess"));
      });
    } else {
      print("Form invalid validation");
    }
  }
}
