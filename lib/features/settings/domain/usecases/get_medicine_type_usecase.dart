import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/entities/medicine_type.dart';
import 'package:eksouvan/core/error/failures.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/no_params.dart';
import '../repositories/setting_repository.dart';

@lazySingleton
class GetMedicineTypeUsecase implements UseCase<List<MedicineType>, NoParams> {
  final SettingRepository settingRepository;

  GetMedicineTypeUsecase(this.settingRepository);
  @override
  Future<Either<Failure, List<MedicineType>>> call(NoParams params) async {
    return await settingRepository.getMedicineType();
  }
}
