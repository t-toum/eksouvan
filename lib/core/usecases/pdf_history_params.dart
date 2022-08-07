import 'package:eksouvan/features/appointments/domain/entities/appointment.dart';
import 'package:eksouvan/features/diagnose/domain/entity/diagnose.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:equatable/equatable.dart';

class PdfHistoryParams extends Equatable {
  final Patient? patient;
  final List<Diagnose> listDiagnose;
  final List<Appointment> listAppointment;

  const PdfHistoryParams(
      {this.patient,
      this.listDiagnose = const [],
      this.listAppointment = const []});

  @override
  List<Object?> get props => [patient, listAppointment, listDiagnose];
}
