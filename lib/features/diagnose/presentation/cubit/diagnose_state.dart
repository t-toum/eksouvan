import 'package:eksouvan/core/entities/medicine.dart';
import 'package:eksouvan/features/diagnose/domain/entity/deases.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/constants.dart';

class DiagnoseState extends Equatable {
  const DiagnoseState({
    this.dataStatus = DataStatus.initial,
    this.error,
    this.listPatient,
    this.patient,
    this.listDeases,
    this.listMedicine,
  });

  final DataStatus dataStatus;
  final String? error;
  final List<Patient>? listPatient;
  final Patient? patient;
  final List<Deases>? listDeases;
  final List<Medicine>? listMedicine;

  @override
  List<Object?> get props =>
      [dataStatus, listPatient, error, patient, listDeases, listMedicine];

  DiagnoseState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<Patient>? listPatient,
    Patient? patient,
    List<Deases>? listDeases,
    List<Medicine>? listMedicine,
  }) {
    return DiagnoseState(
        dataStatus: dataStatus ?? this.dataStatus,
        error: error ?? this.error,
        listPatient: listPatient ?? this.listPatient,
        patient: patient ?? this.patient,
        listDeases: listDeases ?? this.listDeases,
        listMedicine: listMedicine ?? this.listMedicine);
  }
}
