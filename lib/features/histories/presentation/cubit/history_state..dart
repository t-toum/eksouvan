import 'package:eksouvan/features/diagnose/domain/entity/diagnose.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/constants.dart';
import '../../../register/domain/entity/patient.dart';

class HistoryState extends Equatable {
  const HistoryState({
    this.dataStatus = DataStatus.initial,
    this.error,
    this.listPatient = const [],
    this.patient,
    this.listDiagnose = const [],
    this.diagnose,
  });

  final DataStatus dataStatus;
  final String? error;
  final List<Patient> listPatient;
  final Patient? patient;
  final List<Diagnose> listDiagnose;
  final Diagnose? diagnose;
  @override
  List<Object?> get props => [dataStatus, error, listPatient, listDiagnose];
  HistoryState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<Patient>? listPatient,
    Patient? patient,
    List<Diagnose>? listDiagnose,
    Diagnose? diagnose,
  }) {
    return HistoryState(
        dataStatus: dataStatus ?? this.dataStatus,
        error: error ?? this.error,
        listPatient: listPatient ?? this.listPatient,
        patient: patient ?? this.patient,
        listDiagnose: listDiagnose ?? this.listDiagnose,
        diagnose: diagnose ?? this.diagnose);
  }
}
