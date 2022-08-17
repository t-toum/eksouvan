import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/features/home/domain/usecases/get_logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/todo.dart';
import '../../domain/usecases/get_todos_usecase.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetTodo getTodo;
  final GetLogoutUsecase getLogoutUsecase;
  HomeCubit({required this.getTodo, required this.getLogoutUsecase})
      : super(const HomeState());

  Future<void> fetchTodoList() async {
    final req = await getTodo(NoParams());
    req.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (todoList) => emit(state.copyWith(
            dataStatus: DataStatus.success, todoList: todoList)));
  }

  Future<void> getLogOut() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getLogoutUsecase(NoParams());
    await Future.delayed(const Duration(seconds: 3));
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      emit(state.copyWith(dataStatus: DataStatus.success));
      AppNavigator.pushAndRemoveUntil(AppRoute.loginRoute);
    });
  }

  Future<void> refeshSate() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    Future.delayed(const Duration(milliseconds: 100), () async {
      emit(state.copyWith(dataStatus: DataStatus.success));
    });
  }
}
