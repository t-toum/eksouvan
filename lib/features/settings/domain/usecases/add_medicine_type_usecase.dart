import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/models/medicine_type_mode.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class AddMedicineTypeUsecase
    implements UseCase<dynamic, AddMedicineTypeUsecaseParams> {
  final SettingRepository settingRepository;

  AddMedicineTypeUsecase(this.settingRepository);

  @override
  Future<Either<Failure, dynamic>> call(
      AddMedicineTypeUsecaseParams params) async {
    return await settingRepository.addMedicineType(data: params.data);
  }
}

class AddMedicineTypeUsecaseParams extends Equatable {
  final MedicineTypeMedel data;

  const AddMedicineTypeUsecaseParams({required this.data});

  @override
  List<Object?> get props => [data];
}
