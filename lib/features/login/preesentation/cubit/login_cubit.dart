import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/login/domain/usecase/login_usecase.dart';
import 'package:eksouvan/features/login/preesentation/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit(this.loginUsecase) : super(const LoginState());

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final userCredentail =
        await loginUsecase(LoginParams(email: email, password: password));
    userCredentail.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (result) {
      emit(state.copyWith(dataStatus: DataStatus.success));
    });
  }
}
