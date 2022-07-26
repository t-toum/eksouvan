import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:equatable/equatable.dart';

class DailyPatientState extends Equatable {
  final DataStatus dataStatus;
  final String? error;
  final List<Patient>? listPatient;
  final Patient? patient;

  const DailyPatientState(
      {this.dataStatus = DataStatus.initial,
      this.error,
      this.listPatient,
      this.patient});
  @override
  List<Object?> get props => [dataStatus, error, listPatient, patient];

  DailyPatientState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<Patient>? listPatient,
    Patient? patient,
  }) {
    return DailyPatientState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
      listPatient: listPatient ?? this.listPatient,
      patient: patient ?? this.patient,
    );
  }
}
