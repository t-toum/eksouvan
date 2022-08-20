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
    DateTime? lastUpdate,
    int? gender,
    double? height,
    double? weight,
    String? congnitialDeases,
    String? bloodType,
  }) : super(
          patientId: patientId,
          firstname: firstname,
          lastname: lastname,
          address: address,
          tel: tel,
          birthday: birthday,
          userId: userId,
          createDate: createDate,
          lastUpdate: lastUpdate,
          gender: gender,
          height: height,
          weight: weight,
          congenitalDeases: congnitialDeases,
          bloodType: bloodType,
        );
  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}
