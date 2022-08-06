import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/appointments/data/models/appointment_model.dart';
import 'package:eksouvan/features/appointments/domain/repositories/appoint_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class AddApointmentUsecase implements UseCase<String, AppointmentParams> {
  final AppointmentRepository appointmentRepository;
  AddApointmentUsecase(this.appointmentRepository);
  @override
  Future<Either<Failure, String>> call(AppointmentParams params) async {
    return await appointmentRepository.addAppointment(data: params.data);
  }
}

class AppointmentParams extends Equatable {
  final AppointmentModel data;

  const AppointmentParams({required this.data});
  @override
  List<Object?> get props => [data];
}
