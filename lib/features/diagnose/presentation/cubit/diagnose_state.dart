import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/constants.dart';

class DiagnoseState extends Equatable {
  const DiagnoseState({
    this.dataStatus = DataStatus.initial,
    this.error,
    this.listPatient,
    this.patient,
  });

  final DataStatus dataStatus;
  final String? error;
  final List<Patient>? listPatient;
  final Patient? patient;

  @override
  List<Object?> get props => [dataStatus, listPatient, error, patient];

  DiagnoseState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<Patient>? listPatient,
    Patient? patient,
  }) {
    return DiagnoseState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
      listPatient: listPatient ?? this.listPatient,
      patient: patient ?? this.patient,
    );
  }
}
