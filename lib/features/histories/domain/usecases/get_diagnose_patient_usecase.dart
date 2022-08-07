import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/diagnose/domain/entity/diagnose.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/history_repository.dart';

@lazySingleton
class GetDiagnosePatientUsecase
    implements UseCase<Diagnose, GetDiagnoseParams> {
  final HistoryRepository historyRepository;

  GetDiagnosePatientUsecase(this.historyRepository);

  @override
  Future<Either<Failure, Diagnose>> call(GetDiagnoseParams params) async {
    return await historyRepository.getDiagnose(patientId: params.patientId);
  }
}

class GetDiagnoseParams extends Equatable {
  final String patientId;

  const GetDiagnoseParams(this.patientId);

  @override
  List<Object?> get props => [patientId];
}
