import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/todo.dart';
import '../../domain/usecases/get_todos_usecase.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetTodo getTodo;
  HomeCubit({required this.getTodo}) : super(const HomeState());

  Future<void> fetchTodoList() async {
    final req = await getTodo(NoParams());
    req.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (todoList) => emit(state.copyWith(
            dataStatus: DataStatus.success, todoList: todoList)));
  }
}
