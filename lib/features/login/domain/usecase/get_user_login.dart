import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/login/domain/repositoies/login_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserLogin implements UseCase<String?, NoParams> {
  final LoginRepository loginRepository;

  GetUserLogin(this.loginRepository);
  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    return await loginRepository.getLoginUser();
  }
}
