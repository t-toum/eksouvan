import 'package:eksouvan/features/appointments/domain/entities/appointment.dart';
import 'package:json_annotation/json_annotation.dart';
part 'appointment_model.g.dart';
@JsonSerializable()
class AppointmentModel extends Appointment {
  AppointmentModel(
    String? docId,
    String? patientId,
    DateTime? appointmentDate,
    DateTime? dueDate,
    String? description,
  ) : super(
          docId: docId,
          patientId: patientId,
          appointmentDate: appointmentDate,
          dueDate: dueDate,
          description: description,
        );
  factory AppointmentModel.formJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}
