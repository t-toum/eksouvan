import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/constants.dart';

class ReportState extends Equatable {
  const ReportState({
    this.dataStatus = DataStatus.initial,
    this.error,
    this.listPatient = const [],
  });

  final DataStatus dataStatus;
  final String? error;
  final List<Patient> listPatient;

  ReportState copyWith(
      {DataStatus? dataStatus, String? error, List<Patient>? listPatient}) {
    return ReportState(
        dataStatus: dataStatus ?? this.dataStatus,
        error: error ?? this.error,
        listPatient: listPatient ?? this.listPatient);
  }

  @override
  List<Object?> get props => [error, dataStatus];
}
