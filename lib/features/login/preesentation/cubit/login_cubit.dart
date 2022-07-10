import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/login/domain/usecase/login_usecase.dart';
import 'package:eksouvan/features/login/preesentation/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';
import '../../domain/usecase/get_user_login.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  final GetUserLogin getUserLogin;
  LoginCubit(this.loginUsecase, this.getUserLogin) : super(const LoginState());

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final userCredentail =
        await loginUsecase(LoginParams(email: email, password: password));
    userCredentail.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (result) {
      emit(state.copyWith(dataStatus: DataStatus.success));
      AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
    });
  }

  Future<void> initialLogin() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getUserLogin(NoParams());
    result.fold(
        (error) =>
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg),
        (success) {
      emit(state.copyWith(dataStatus: DataStatus.success, uid: success));
    });
  }
}
