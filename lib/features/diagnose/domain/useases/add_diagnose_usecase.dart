import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:eksouvan/features/diagnose/domain/repositories/diagnose_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddDiagnoseUsecase implements UseCase<String, AddDiagnoseParams> {
  final DiagnoseRepository diagnoseRepository;

  AddDiagnoseUsecase(this.diagnoseRepository);
  @override
  Future<Either<Failure, String>> call(AddDiagnoseParams params) async {
    return await diagnoseRepository.addDiagnose(data: params.data);
  }
}

class AddDiagnoseParams extends Equatable {
  final DiagnoseModel data;

  const AddDiagnoseParams({required this.data});

  @override
  List<Object?> get props => [data];
}
