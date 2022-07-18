import 'package:equatable/equatable.dart';

class Diagnose extends Equatable {
  final String? diagnoseId;
  final DateTime? diagnoseDate;
  final String? description;
  final String? user;
  final String? patientId;
  const Diagnose({
    this.diagnoseId,
    this.diagnoseDate,
    this.description,
    this.user,
    this.patientId,
  });
  @override
  List<Object?> get props =>
      [diagnoseId, diagnoseDate, description, user, patientId];
}
