import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/histories/domain/repositories/history_repository.dart';
import 'package:eksouvan/features/register_patient/domain/entity/patient.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllPatientUsecase implements UseCase<List<Patient>, NoParams> {
  final HistoryRepository historyRepository;

  GetAllPatientUsecase(this.historyRepository);
  @override
  Future<Either<Failure, List<Patient>>> call(NoParams params) async {
    return await historyRepository.getAllPatient();
  }
}
