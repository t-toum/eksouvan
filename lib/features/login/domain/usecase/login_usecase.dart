import 'package:eksouvan/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/usecase.dart';
import 'package:eksouvan/features/login/domain/repositoies/login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUsecase implements UseCase<UserCredential, LoginParams> {
  final LoginRepository loginRepository;
  LoginUsecase(this.loginRepository);
  @override
  Future<Either<Failure, UserCredential>> call(LoginParams params) async {
    return await loginRepository.getLogin(
        email: params.email, password: params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
