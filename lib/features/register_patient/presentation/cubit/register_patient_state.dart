import 'package:eksouvan/core/utils/constants.dart';
import 'package:equatable/equatable.dart';

class RegisterPatientState extends Equatable {
  final DataStatus dataStatus;
  final String? error;
  final String? patientId;
  const RegisterPatientState(
      {this.dataStatus = DataStatus.initial, this.error, this.patientId});
  @override
  List<Object?> get props => [dataStatus, error, patientId];
  RegisterPatientState copyWith({
    DataStatus? dataStatus,
    String? error,
    String? patientId,
  }) {
    return RegisterPatientState(
        dataStatus: dataStatus ?? this.dataStatus,
        error: error ?? this.error,
        patientId: patientId ?? this.patientId);
  }
}