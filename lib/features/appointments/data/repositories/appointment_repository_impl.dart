
import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/features/appointments/data/datasources/appointment_remote_datasource.dart';
import 'package:eksouvan/features/appointments/data/models/appointment_model.dart';

import 'package:eksouvan/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/appointment.dart';
import '../../domain/repositories/appoint_repository.dart';

@LazySingleton(as: AppointmentRepository)
class AppointmentRepositoryImpl extends AppointmentRepository {
  final AppointmentRemoteDatasource datasource;

  AppointmentRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, String>> addAppointment(
      {required AppointmentModel data}) async {
    try {
      final response = await datasource.addAppointment(data: data);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }
  
  @override
  Future<Either<Failure, List<Appointment>>> getAllAppointment()async {
    try {
      final response = await datasource.getAllAppointment();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.msg));
    }
  }
}
