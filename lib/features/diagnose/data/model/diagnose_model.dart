import 'package:eksouvan/features/diagnose/domain/entity/diagnose.dart';
import 'package:json_annotation/json_annotation.dart';
part 'diagnose_model.g.dart';

@JsonSerializable()
class DiagnoseModel extends Diagnose {
  const DiagnoseModel({
    String? diagnoseId,
    DateTime? diagnoseDate,
    String? description,
    String? patientId,
    String? userId,
    double? bloodPressure,
    double? weight,
    double? temperature,
    String? allergic,
  }) : super(
          diagnoseId: diagnoseId,
          diagnoseDate: diagnoseDate,
          description: description,
          patientId: patientId,
          userId: userId,
          bloodPressure: bloodPressure,
          weight: weight,
          temperature: temperature,
          allergic: allergic,
        );

  factory DiagnoseModel.fromJson(Map<String, dynamic> json) =>
      _$DiagnoseModelFromJson(json);
  Map<String, dynamic> toJson() => _$DiagnoseModelToJson(this);
}
