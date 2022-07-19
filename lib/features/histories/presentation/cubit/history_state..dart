import 'package:equatable/equatable.dart';

import '../../../../core/utils/constants.dart';
import '../../../register/domain/entity/patient.dart';

class HistoryState extends Equatable {
  const HistoryState({
    this.dataStatus = DataStatus.initial,
    this.error,
    this.listPatient = const [],
    this.patient,
  });

  final DataStatus dataStatus;
  final String? error;
  final List<Patient> listPatient;
  final Patient? patient;
  @override
  List<Object?> get props => [dataStatus, error, listPatient];
  HistoryState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<Patient>? listPatient,
    Patient? patient,
  }) {
    return HistoryState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
      listPatient: listPatient ?? this.listPatient,
      patient: patient??this.patient
    );
  }
}
