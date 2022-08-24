import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/setting_repository.dart';

@lazySingleton
class DeleteMedicineUsecase
    implements UseCase<bool, DeleteMedicineParams> {
  final SettingRepository settingRepository;

  DeleteMedicineUsecase(this.settingRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteMedicineParams params) async {
    return await settingRepository.deleteMedicine(id: params.id);
  }
}

class DeleteMedicineParams extends Equatable {
  final String id;

  const DeleteMedicineParams({required this.id});

  @override
  List<Object?> get props => [id];
}
