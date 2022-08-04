import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:equatable/equatable.dart';

class AppointmentState extends Equatable {
  const AppointmentState({
    this.dataStatus = DataStatus.initial,
    this.error,
    this.listPatient,
    this.patientId
  });

  final DataStatus? dataStatus;
  final String? error;
  final List<Patient>? listPatient;
  final String? patientId;

  AppointmentState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<Patient>? listPatient,
    String? patientId,
  }) {
    return AppointmentState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
      listPatient: listPatient ?? this.listPatient,
      patientId: patientId??this.patientId
    );
  }

  @override
  List<Object?> get props => [listPatient, error, dataStatus,patientId];
}
