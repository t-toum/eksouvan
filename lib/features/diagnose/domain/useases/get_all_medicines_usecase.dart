import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/entities/medicine.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

import '../repositories/diagnose_repository.dart';

@lazySingleton
class GetAllMedicineUsecase implements UseCase<List<Medicine>, NoParams> {
  final DiagnoseRepository diagnoseRepository;

  GetAllMedicineUsecase(this.diagnoseRepository);

  @override
  Future<Either<Failure, List<Medicine>>> call(NoParams params) async {
    return await diagnoseRepository.getAllMedicine();
  }
}
