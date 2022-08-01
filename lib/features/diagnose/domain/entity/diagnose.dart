import 'package:eksouvan/core/entities/medicine.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/features/diagnose/data/model/deases_model.dart';
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
  final List<DeasesModel>? deases;
  final List<MedicineModel>? medicines;

  const Diagnose({
    this.diagnoseId,
    this.diagnoseDate,
    this.description,
    this.userId,
    this.patientId,
    this.bloodPressure,
    this.weight,
    this.temperature,
    this.allergic,
    this.deases,
    this.medicines,
  });
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
        deases,
        medicines,
      ];
}
