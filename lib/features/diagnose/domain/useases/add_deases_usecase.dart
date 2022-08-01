import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/diagnose/data/model/deases_model.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/diagnose_repository.dart';

@lazySingleton
class AddDeasesUsecase implements UseCase<String, AddDeaseParams> {
  final DiagnoseRepository diagnoseRepository;

  AddDeasesUsecase(this.diagnoseRepository);
  @override
  Future<Either<Failure, String>> call(AddDeaseParams params) async {
    return await diagnoseRepository.addDease(deasesModel: params.deasesModel);
  }
}

class AddDeaseParams extends Equatable {
  final DeasesModel deasesModel;
  const AddDeaseParams({required this.deasesModel});

  @override
  List<Object?> get props => [deasesModel];
}
