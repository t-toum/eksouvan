import 'package:eksouvan/features/register_patient/domain/entity/patient.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/constants.dart';

class DiagnoseState extends Equatable {
  const DiagnoseState({
    this.dataStatus = DataStatus.initial,
    this.error,
    this.listPatient,
  });

  final DataStatus dataStatus;
  final String? error;
  final List<Patient>? listPatient;

  @override
  List<Object?> get props => [dataStatus, listPatient, error];

  DiagnoseState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<Patient>? listPatient,
  }) {
    return DiagnoseState(
        dataStatus: dataStatus ?? this.dataStatus,
        error: error ?? this.error,
        listPatient: listPatient ?? this.listPatient);
  }
}
