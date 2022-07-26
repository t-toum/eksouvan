import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:equatable/equatable.dart';

class DailyPatientState extends Equatable {
  final DataStatus dataStatus;
  final String? error;
  final List<Patient>? listPatient;

  const DailyPatientState(
      {this.dataStatus = DataStatus.initial, this.error, this.listPatient});
  @override
  List<Object?> get props => [dataStatus, error, listPatient];

  DailyPatientState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<Patient>? listPatient,
  }) {
    return DailyPatientState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
      listPatient: listPatient ?? this.listPatient,
    );
  }
}
