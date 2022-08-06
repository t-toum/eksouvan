import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/appointments/domain/entities/appointment.dart';
import 'package:eksouvan/features/appointments/domain/repositories/appoint_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllAppointmentUsecase implements UseCase<List<Appointment>, NoParams> {
  final AppointmentRepository appointmentRepository;

  GetAllAppointmentUsecase(this.appointmentRepository);

  @override
  Future<Either<Failure, List<Appointment>>> call(NoParams params) async {
    return await appointmentRepository.getAllAppointment();
  }
}
