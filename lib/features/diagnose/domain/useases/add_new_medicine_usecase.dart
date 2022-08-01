import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/diagnose_repository.dart';

@lazySingleton
class AddNewMedicineUsecase implements UseCase<String, AddNewMedicineParams> {
  final DiagnoseRepository diagnoseRepository;

  AddNewMedicineUsecase(this.diagnoseRepository);

  @override
  Future<Either<Failure, String>> call(AddNewMedicineParams params) async {
    return await diagnoseRepository.addNewMedicine(data: params.data);
  }
}

class AddNewMedicineParams extends Equatable {
  final MedicineModel data;
  const AddNewMedicineParams(this.data);

  @override
  List<Object?> get props => [data];
}
