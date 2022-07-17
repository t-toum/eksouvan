import 'package:dartz/dartz.dart';

import '../../../../core/entities/todo.dart';
import '../../../../core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, bool>> logOut();
  Future<Either<Failure, String?>> getCurrentUser();
}
