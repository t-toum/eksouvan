import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/usecases/get_logout_usecase.dart';
import '../../domain/usecases/get_lang_usecase.dart';
import '../../domain/usecases/set_lang_usecase.dart';

@injectable
class SettingCubit extends Cubit<SettingState> {
  final GetLogoutUsecase getLogoutUsecase;
  final GetLanguageUsecase getLanguageUsecase;
  final SetLanguageUsecase setLanguageUsecase;
  SettingCubit(
      this.getLogoutUsecase, this.getLanguageUsecase, this.setLanguageUsecase)
      : super(const SettingState());
  bool lang = false;

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

  Future<void> getLang() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getLanguageUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (la) {
      if (la == Languages.loCode || la == "") {
        lang = false;
      } else {
        lang = true;
      }
      emit(state.copyWith(dataStatus: DataStatus.success));
    });
  }

  Future<void> setLang({required String langCode}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result =
        await setLanguageUsecase(SetLanguageParams(langCode: langCode));
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      print(success);
      emit(state.copyWith(dataStatus: DataStatus.success));
    });
  }

  Future<void> onChangedLang(
      {required isCheck, required BuildContext context}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    lang = isCheck;
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (lang == false) {
        context.setLocale(const Locale(Languages.loCode));
        await setLang(langCode: Languages.loCode);
      } else {
        context.setLocale(const Locale(Languages.enCode));
        await setLang(langCode: Languages.enCode);
      }
    });
    emit(state.copyWith(dataStatus: DataStatus.success));
  }

  Future<void> getAllUser() async {}
}
