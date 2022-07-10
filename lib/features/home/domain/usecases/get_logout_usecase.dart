import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLogoutUsecase implements UseCase<bool, NoParams> {
  final HomeRepository homeRepository;

  GetLogoutUsecase(this.homeRepository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return homeRepository.logOut();
  }
}
