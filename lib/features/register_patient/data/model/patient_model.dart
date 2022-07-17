import 'package:eksouvan/features/register_patient/domain/entity/patient.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../diagnose/data/model/diagnose_model.dart';
part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel extends Patient {
  const PatientModel({
    String? patientId,
    String? firstname,
    String? lastname,
    String? address,
    String? tel,
    DateTime? birthday,
    String? user,
    List<DiagnoseModel?>? diagnoses,
  }) : super(
          patientId: patientId,
          firstname: firstname,
          lastname: lastname,
          address: address,
          tel: tel,
          birthday: birthday,
          diagnoses: diagnoses ?? const [],
          user: user,
        );
  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}
