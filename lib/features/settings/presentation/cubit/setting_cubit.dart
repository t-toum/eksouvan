import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/usecases/get_logout_usecase.dart';

@injectable
class SettingCubit extends Cubit<SettingState> {
  final GetLogoutUsecase getLogoutUsecase;
  SettingCubit(this.getLogoutUsecase) : super(const SettingState());

  Future<void> getLogout() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getLogoutUsecase(NoParams());
    result.fold(
        (l) =>
            emit(state.copyWith(dataStatus: DataStatus.failure, error: l.msg)),
        (r) {
      emit(state.copyWith(dataStatus: DataStatus.success));
      AppNavigator.pushAndRemoveUntil(AppRoute.loginRoute);
    });
  }

  Future<void> getAllUser() async {}
}
