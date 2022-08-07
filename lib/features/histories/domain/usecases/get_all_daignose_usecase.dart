import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/diagnose/domain/entity/diagnose.dart';
import 'package:eksouvan/features/histories/domain/repositories/history_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllDiagnoseUsecase implements UseCase<List<Diagnose>, NoParams> {
  final HistoryRepository historyRepository;

  GetAllDiagnoseUsecase(this.historyRepository);

  @override
  Future<Either<Failure, List<Diagnose>>> call(NoParams params) async {
    return await historyRepository.getAllDiagnose();
  }
}
