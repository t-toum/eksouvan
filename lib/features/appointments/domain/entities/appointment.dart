import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final String? docId;
  final String? patientId;
  final DateTime? appointmentDate;
  final DateTime? dueDate;
  final String? description;

  const Appointment(
      {this.docId, this.patientId, this.appointmentDate, this.dueDate,this.description});

  @override
  List<Object?> get props => [docId, patientId, appointmentDate, dueDate,description];
}
