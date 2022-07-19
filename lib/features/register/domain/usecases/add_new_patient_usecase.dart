import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/register/data/model/patient_model.dart';
import 'package:eksouvan/features/register/domain/repositories/register_patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddNewPatientUsecase implements UseCase<String, AddNewPatientParams> {
  final RegisterPaientRepository registerPaientRepository;

  AddNewPatientUsecase(this.registerPaientRepository);
  @override
  Future<Either<Failure, String>> call(AddNewPatientParams params) async {
    return registerPaientRepository.addNewPatient(
        patientModel: params.patientModel);
  }
}

class AddNewPatientParams extends Equatable {
  final PatientModel patientModel;

  const AddNewPatientParams({required this.patientModel});
  @override
  List<Object?> get props => [patientModel];
}
