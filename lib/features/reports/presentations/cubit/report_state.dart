import 'package:eksouvan/features/diagnose/domain/entity/diagnose.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/constants.dart';

class ReportState extends Equatable {
  const ReportState({
    this.dataStatus = DataStatus.initial,
    this.error,
    this.listPatient = const [],
    this.listDiagnose = const [],
  });

  final DataStatus dataStatus;
  final String? error;
  final List<Patient> listPatient;
  final List<Diagnose> listDiagnose;

  ReportState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<Patient>? listPatient,
    List<Diagnose>? listDiagnose,
  }) {
    return ReportState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
      listPatient: listPatient ?? this.listPatient,
      listDiagnose: listDiagnose ??this.listDiagnose
    );
  }

  @override
  List<Object?> get props => [error, dataStatus,listDiagnose];
}
