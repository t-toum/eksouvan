import 'package:equatable/equatable.dart';

class Diagnose extends Equatable {
  final String? diagnoseId;
  final DateTime? diagnoseDate;
  final String? description;
  final String? userId;
  final String? patientId;
  final double? bloodPressure;
  final double? weight;
  final double? temperature;
  final String? allergic;

  const Diagnose(
      {this.diagnoseId,
      this.diagnoseDate,
      this.description,
      this.userId,
      this.patientId,
      this.bloodPressure,
      this.weight,
      this.temperature,
      this.allergic});
  @override
  List<Object?> get props => [
        diagnoseId,
        diagnoseDate,
        description,
        userId,
        patientId,
        bloodPressure,
        weight,
        temperature,
        allergic,
      ];
}
