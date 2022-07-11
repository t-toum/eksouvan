import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';
import 'package:eksouvan/features/register_patient/domain/usecases/add_new_patient_usecase.dart';
import 'package:eksouvan/features/register_patient/presentation/cubit/register_patient_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterPatientCubit extends Cubit<RegisterPatientState> {
  final AddNewPatientUsecase addNewPatientUsecase;
  RegisterPatientCubit({required this.addNewPatientUsecase})
      : super(const RegisterPatientState());
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameController = TextEditingController();

  Future<void> addNewPatient() async {
    if (formKey.currentState!.saveAndValidate()) {
      Map<String, dynamic> formValue = {};
      formKey.currentState?.value.forEach((key, value) {
        formValue[key] = value;
        if (value is DateTime) {
          formValue[key] = value.toString();
        }
      });
      print(formValue);
      PatientModel patientModel =
          PatientModel.fromJson(formValue);
      final result = await addNewPatientUsecase(
          AddNewPatientParams(patientModel: patientModel));
      result.fold((error) {
        print(error);
      }, (success) {
        print(success);
      });
    } else {
      print("Form invalid validation");
    }
  }
}
