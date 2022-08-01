import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/diagnose/domain/entity/deases.dart';
import 'package:eksouvan/features/diagnose/domain/repositories/diagnose_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllDeaseUsecase implements UseCase<List<Deases>, NoParams> {
  final DiagnoseRepository diagnoseRepository;

  GetAllDeaseUsecase(this.diagnoseRepository);
  @override
  Future<Either<Failure, List<Deases>>> call(NoParams params) async {
    return await diagnoseRepository.getAllDeases();
  }
}
