import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/features/appointments/data/models/appointment_model.dart';
import 'package:eksouvan/features/appointments/domain/entities/appointment.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, String>> addAppointment(
      {required AppointmentModel data});
  Future<Either<Failure,List<Appointment>>>getAllAppointment();
}
