import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/patient.dart';
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
    String? userId,
    DateTime? createDate,
    DateTime? updateDate,
    int? gender,
    double? height,
    double? weight,
    String? congnitialDeases,
  }) : super(
          patientId: patientId,
          firstname: firstname,
          lastname: lastname,
          address: address,
          tel: tel,
          birthday: birthday,
          userId: userId,
          createDate: createDate,
          updateDate: updateDate,
          gender: gender,
          height: height,
          weight: weight,
          congenitalDeases: congnitialDeases,
        );
  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}
