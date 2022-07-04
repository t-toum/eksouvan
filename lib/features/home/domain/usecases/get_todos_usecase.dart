import 'package:dartz/dartz.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/todo.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

@lazySingleton
class GetTodo implements UseCase<List<Todo>, NoParams> {
  final HomeRepository homeRepository;

  GetTodo(this.homeRepository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams noParams) async {
    return await homeRepository.getTodos();
  }
}