import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/register_patient/domain/entity/patient.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/history_repository.dart';

@lazySingleton
class GetPatientUsecase implements UseCase<Patient, GetPatientParams> {
  final HistoryRepository historyRepository;

  GetPatientUsecase(this.historyRepository);
  @override
  Future<Either<Failure, Patient>> call(GetPatientParams params) async {
    return await historyRepository.getPatient(patientId: params.patientId);
  }
}

class GetPatientParams extends Equatable {
  final String patientId;
  const GetPatientParams({required this.patientId});

  @override
  List<Object?> get props => [patientId];
}
