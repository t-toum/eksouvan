import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/diagnose/domain/repositories/diagnose_repository.dart';
import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddDiagnoseUsecase implements UseCase<bool, AddDiagnoseParams> {
  final DiagnoseRepository diagnoseRepository;

  AddDiagnoseUsecase(this.diagnoseRepository);
  @override
  Future<Either<Failure, bool>> call(AddDiagnoseParams params) async {
    return await diagnoseRepository.addDiagnose(
        doc: params.doc, patient: params.patientModel);
  }
}

class AddDiagnoseParams extends Equatable {
  final String doc;
  final PatientModel patientModel;

  const AddDiagnoseParams({required this.doc, required this.patientModel});

  @override
  List<Object?> get props => [doc, patientModel];
}
